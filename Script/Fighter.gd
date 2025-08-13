extends Node2D
class_name Fighter
signal died

@export var max_hp: int = 100
@export var attack: int = 10
@export var attack_speed: float = 1.0
@export var crit_chance: float = 0.1
@export var dodge_chance: float = 0.05

# ⭐ 外观相关（每个实例单独设置）
@export var sprite_texture: Texture2D
@export var sprite_tint: Color = Color(1, 1, 1, 1)   # 颜色染色
@export var flip_h: bool = false                    # 水平翻转（面朝左右）
@export var flip_v: bool = false                    # 垂直翻转（面朝上下）

var hp: int
var target: Fighter
@onready var bar: ProgressBar = $ProgressBar
@onready var sprite: Sprite2D = $Sprite2D
var attack_timer: Timer


func _ready() -> void:
	# 初始化数值
	hp = max_hp
	bar.max_value = max_hp
	bar.value = hp

	# ⭐ 应用外观
	if sprite_texture:
		sprite.texture = sprite_texture
	sprite.modulate = sprite_tint
	sprite.flip_h = flip_h
	sprite.flip_v = flip_v

	# 攻击计时器
	attack_timer = Timer.new()
	attack_timer.one_shot = false
	add_child(attack_timer)
	_refresh_attack_timer()

func _refresh_attack_timer() -> void:
	attack_timer.wait_time = 1.0 / max(0.01, attack_speed)

func start_auto_attack(t: Fighter) -> void:
	target = t
	if not attack_timer.timeout.is_connected(_on_attack_timeout):
		attack_timer.timeout.connect(_on_attack_timeout)
	attack_timer.start()

func stop_auto_attack() -> void:
	attack_timer.stop()


func _spawn_damage_popup(amount: int, is_crit: bool = false) -> void:
	var popup = preload("res://Scence/DamagePopup.tscn").instantiate()  # 注意是 .tscn 的实际路径
	get_tree().current_scene.add_child(popup)
	popup.global_position = global_position + Vector2(0, -70)
	popup.show_damage(amount, is_crit)


func _hit_flash(is_crit: bool = false) -> void:
	if not sprite: return
	var tw := create_tween()
	var original := sprite.modulate
	# 暴击更亮一点
	
	sprite.modulate =  Color(2, 2, 2, 1) if is_crit else Color(1.5, 1.5, 1.5, 1)
	tw.tween_interval(0.05)
	tw.tween_callback(func(): sprite.modulate = original)



func apply_damage(amount: int, is_crit: bool = false) -> void:
	hp = max(0, hp - amount)
	bar.value = hp
	_spawn_damage_popup(amount, is_crit)
	_hit_flash(is_crit)
	if hp == 0:
		emit_signal("died")


func _on_attack_timeout() -> void:
	if hp <= 0: return
	if target and is_instance_valid(target) and target.hp > 0:
		# 闪避判定
		if randf() < target.dodge_chance:
			target.show_dodge()  # 显示闪避提示
			return
		
		var damage = attack
		var is_crit = false
		# 暴击判定
		if randf() < crit_chance:
			damage = int(damage * 1.5)  # 暴击伤害 1.5 倍，可调
			is_crit = true
		target.apply_damage(damage, is_crit)

func show_dodge() -> void:
	var popup = preload("res://Scence/DamagePopup.tscn").instantiate()
	get_tree().current_scene.add_child(popup)
	popup.global_position = global_position + Vector2(0, -70)
	popup.show_dodge()
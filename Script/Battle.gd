extends Node2D

@onready var ally: Fighter = $ally
@onready var enemy: Fighter = $enemy

func _ready() -> void:
	ally.died.connect(_on_ally_died)
	enemy.died.connect(_on_enemy_died)

	ally.start_auto_attack(enemy)
	enemy.start_auto_attack(ally)

func _on_ally_died() -> void:
	enemy.stop_auto_attack()
	_show_result("Defeat")

func _on_enemy_died() -> void:
	ally.stop_auto_attack()
	_show_result("Victory")

func _show_result(text: String) -> void:
	var label := Label.new()
	label.text = text
	label.scale = Vector2(2, 2)
	label.position = Vector2(1280/2 - 60, 720/2 - 20) # 按你窗口大小微调
	add_child(label)
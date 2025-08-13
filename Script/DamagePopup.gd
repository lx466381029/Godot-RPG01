extends Node2D
class_name DamagePopup

@onready var label: Label = $Label

func show_damage(amount: int, is_crit: bool = false) -> void:
	label.text = str(amount) + ("!" if is_crit else "")
	label.add_theme_font_size_override("font_size", 32 if is_crit else 24)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_color_override("font_color", Color.YELLOW if is_crit else Color.RED)
	_animate_popup()

func show_dodge() -> void:
	label.text = "Miss"
	label.add_theme_font_size_override("font_size", 26)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_color_override("font_color", Color.CYAN)
	_animate_popup()

func _animate_popup() -> void:
	modulate.a = 0.0
	position.y -= 10
	var tw := create_tween()
	tw.tween_property(self, "modulate:a", 1.0, 0.15)
	tw.tween_property(self, "position:y", position.y - 30, 0.6)
	tw.parallel().tween_property(self, "modulate:a", 0.0, 0.6)
	tw.finished.connect(queue_free)
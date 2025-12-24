extends Button

var slide_distance: float = 8.0
var base_pos: Vector2
var pivot_point: Vector2

func _ready() -> void:
	base_pos = position
	pivot_point = (self.size / 2)

func _on_mouse_entered() -> void:
	print("Stat mouse entered")
	var tween = create_tween()
	#Goes OUTWARDS
	tween.tween_property(self, "position", base_pos + Vector2(slide_distance, 0), 0.05).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.04, 1.04), 0.03).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	print("Stat mouse exited")
	var tween = create_tween()
	#Goes OUTWARDS
	tween.tween_property(self, "position", base_pos, 0.05).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.03).set_ease(Tween.EASE_IN)

func _on_button_down() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.03).set_ease(Tween.EASE_IN)

func _on_button_up() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.03).set_ease(Tween.EASE_OUT)
	EventBus.change_to_stat.emit()

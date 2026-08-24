extends Control

const SCREEN_CENTER := Vector2(576,324)
const OFFSET = 10
var relative_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	relative_position = (mouse_position-SCREEN_CENTER)/SCREEN_CENTER

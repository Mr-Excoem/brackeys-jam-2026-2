extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	position = get_global_mouse_position() + Vector2(0,48)

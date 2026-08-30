extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	offset = MouseParallax.relative_position*9

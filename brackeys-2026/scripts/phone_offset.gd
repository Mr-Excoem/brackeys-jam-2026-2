extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if BombTimer.is_bomb_solved:
		return
	offset = -MouseParallax.relative_position*8

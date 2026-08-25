extends Sprite2D

var relative := Vector2.ZERO
var mouse_speed := Vector2.ZERO
@onready var previous_mouse_position := get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = get_global_mouse_position() + Vector2(0,48) + relative*1.5
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_speed = event.position - previous_mouse_position
		previous_mouse_position = event.position
		relative = event.relative

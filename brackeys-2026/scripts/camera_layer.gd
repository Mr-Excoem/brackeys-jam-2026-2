extends CanvasLayer

const UP = -1
const DOWN = 1
var direction:int = 1

var camera_offset:int = 20
var speed:int = 10

@onready var camera = $Camera2D
@onready var screen = $ColorRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if BombTimer.on_titlescreen:
		return
	# bomb shaking
	camera.position.y += speed * direction
	if camera.position.y <= camera_offset * UP:
		direction = DOWN
	elif camera.position.y >= camera_offset * DOWN:
		direction = UP
	speed = max((20-BombTimer.time_left)/4,0)
	camera_offset = speed*1.2
	
	#screen become lighter
	if max((20-BombTimer.time_left),0):
		screen.color.a = (20-BombTimer.time_left)/20

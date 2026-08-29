extends CanvasLayer

const UP = -1
const DOWN = 1
var direction:int = 1

var camera_offset:int = 20
var speed:int = 10

@onready var camera = $Camera2D
@onready var screen = $ColorRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if BombTimer.on_titlescreen or BombTimer.is_bomb_solved:
		#reset everything
		speed = 0
		camera_offset = 0
		direction = 0
		screen.color.a = 0
		return
	# bomb shaking
	camera.position.y += speed * direction
	if camera.position.y <= camera_offset * UP:
		direction = DOWN
	elif camera.position.y >= camera_offset * DOWN:
		direction = UP
	speed = max((BombTimer.WARNING_TIME-BombTimer.time_left)/4,0)
	camera_offset = speed
	
	#screen become lighter
	if max((BombTimer.WARNING_TIME-BombTimer.time_left),0):
		screen.color.a = (BombTimer.WARNING_TIME-BombTimer.time_left)/20
	

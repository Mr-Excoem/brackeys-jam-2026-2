extends CanvasLayer

const UP := -1
const DOWN := 1
var direction := 1

var camera_offset := 20
var speed := 10

@onready var camera := $Camera2D
@onready var screen := $ColorRect
@onready var noise := $Noise

func _ready():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if BombTimer.on_titlescreen \
	or BombTimer.is_bomb_solved:
		#reset everything
		speed = 0
		camera_offset = 0
		direction = 0
		screen.color.a = 0
		if BombTimer.is_bomb_solved:
			noise.stop()
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
	if BombTimer.time_left <= BombTimer.WARNING_TIME:
		screen.color.a = (BombTimer.WARNING_TIME-BombTimer.time_left)/20
	else:
		screen.color.a = 0
	
	if BombTimer.is_stopped():
		noise.stop()
		$End.show()
		set_process(false)
	
	#set noise volume
	noise.volume_db = BombTimer.WARNING_TIME - BombTimer.time_left - 20
	


func _on_end_meta_clicked(_meta: Variant) -> void:
	get_tree().reload_current_scene()

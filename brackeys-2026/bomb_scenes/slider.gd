extends Node2D

const BORDER = 4

# both of these two are relative to the slider's position
@export var start_point:Vector2
@export var end_point:Vector2

@onready var block := $Sprite2D

var line_vector:Vector2
# from 0 to 1
var pos:float

signal state_changed(new_pos:float)

func _ready():
	$Base.points = PackedVector2Array([start_point, end_point])
	line_vector = end_point - start_point
	
	set_process(false)

func _process(_delta):
	var mouse_vector = get_local_mouse_position() - start_point
	var block_vector:Vector2
	if line_vector > Vector2.ZERO:
		block_vector = mouse_vector.project(line_vector).clamp(Vector2.ZERO,line_vector)
	elif line_vector < Vector2.ZERO:
		block_vector = mouse_vector.project(line_vector).clamp(line_vector,Vector2.ZERO)
	else:
		assert(false, "The length of slider is zero!")
	block.position = start_point + block_vector
	pos = block_vector.length()/line_vector.length()

func _input(event):
	if event is InputEventMouseMotion and is_processing():
		state_changed.emit(pos)

func _on_button_down() -> void:
	set_process(true)

func _on_button_up() -> void:
	set_process(false)

func disable():
	$Sprite2D/Button.disabled = true
	set_process(false)

func enable():
	$Sprite2D/Button.disabled = false

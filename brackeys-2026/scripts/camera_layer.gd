extends CanvasLayer 
 
const UP := -1 
const DOWN := 1 
var direction := 1 
 
var camera_offset := 20 
var speed := 10 
 
@onready var camera := $Camera2D 
@onready var screen := $ColorRect 
@onready var noise := $Noise 
@onready var end_text: RichTextLabel = $End 
 
 
func _ready(): 
	set_process(false) 
 
 
func _process(_delta: float) -> void: 
	if BombTimer.on_titlescreen: 
		speed = 0 
		camera_offset = 0 
		direction = 0 
		screen.color.a = 0 
		return 
 
	if BombTimer.is_bomb_solved: 
		# Bomb was successfully defused 
		speed = 1
		camera_offset = 0 
		direction = 0 
		noise.stop() 
		var fade_tween = create_tween()
		fade_tween.tween_property(screen, "color:a", 1.0, 1.0)
		end_text.text = "[shake] You trusted the right person. Good job." 
 
		await get_tree().create_timer(2.0).timeout 
		$End.show() 
		set_process(false) 
		return 
 
	# Bomb shaking 
	camera.position.y += speed * direction 
 
	if camera.position.y <= camera_offset * UP: 
		direction = DOWN 
	elif camera.position.y >= camera_offset * DOWN: 
		direction = UP 
 
	speed = max((BombTimer.WARNING_TIME - BombTimer.time_left) / 4, 0) 
	camera_offset = speed 
 
	# Screen becomes lighter 
	if BombTimer.time_left <= BombTimer.WARNING_TIME: 
		screen.color.a = (BombTimer.WARNING_TIME - BombTimer.time_left) / 20 
	else: 
		screen.color.a = 0 
 
	# Timer ran out 
	if BombTimer.is_stopped(): 
		noise.stop() 
 
 
		$End.show() 
		set_process(false) 
 
	# Set noise volume 
	noise.volume_db = BombTimer.WARNING_TIME - BombTimer.time_left - 20 
 
 
func _on_end_meta_clicked(_meta: Variant) -> void: 
	get_tree().reload_current_scene()

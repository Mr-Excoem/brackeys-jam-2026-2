extends Node2D

#var time_left = 60.0
var correct_red = false
var correct_blue = true
var correct_green = false
var time_up := false

@onready var game_title: RichTextLabel = $CanvasLayer/GameTitle

func _ready():
	BombTimer.on_titlescreen = true
	$AnimationPlayer.play("titlescreen_init")

# the menu buttons
func _on_start_pressed() -> void:
	$AnimationPlayer.play("titlescree_out")
	game_title.visible = false
	await $AnimationPlayer.animation_finished
	BombTimer.on_titlescreen = false
	
	$MiscLayer.set_process(true)
	
	#start dialogue
	show_dialogue()


func _on_credit_pressed() -> void:
	$CreditLayer.show()


func _on_credit_screen_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		$CreditLayer.hide()


func _on_quit_pressed() -> void:
	get_tree().quit()


var dialogue_index = 0

var dialogue = [
	{"speaker": "Agnes", "text": "The blue light is on."},
	{"speaker": "Delilah", "text": "No, it isn't!"},
	
	{"speaker": "Agnes", "text": "Look at the red light. It's clearly off."},
	{"speaker": "Delilah", "text": "The red light is ON."},
	
	{"speaker": "Agnes", "text": "I already told you, the blue light is on."},
	{"speaker": "Delilah", "text": "And the green light is on too."},
	
	{"speaker": "Agnes", "text": "Don't turn the green light on."},
	{"speaker": "Delilah", "text": "You should turn it on."},
	
	{"speaker": "Agnes", "text": "Just leave the red light off."},
	{"speaker": "Delilah", "text": "No. Turn the red light on."}
]

var chat_message_scene = preload("res://scenes/ChatMessage.tscn")
@onready var phone = $CanvasLayer/Phone

func show_dialogue():
	if dialogue_index >= dialogue.size():
		return
	
	await phone.add_dialogue(
		dialogue[dialogue_index]["speaker"],
		dialogue[dialogue_index]["text"]
	)
	
	await get_tree().process_frame
	_on_message_finished()
	
func _on_message_finished():
	dialogue_index += 1
	
	await get_tree().create_timer(
		randf_range(0.3,2)
	).timeout
	
	show_dialogue()

@onready var bomb = $Bomb
#in this case, red_on is bomb.red_button.on

func _input(_event):
	check_solution()

func _process(_delta):
	if BombTimer.is_bomb_solved or time_up:
		return
		
	if BombTimer.is_stopped() \
	and not BombTimer.is_bomb_solved \
	and not BombTimer.on_titlescreen:
		time_up = true
		bomb.disable()
		print("TIME'S UP!")
	
	#move the canva according to mouse movation
	#and after game finished (bomb solved or exploded) this effect disappear
	position = MouseParallax.relative_position*3
	

func check_solution():
	if BombTimer.is_bomb_solved:
		return
	
	if bomb.red_button.on == correct_red \
	and bomb.blue_button.on == correct_blue \
	and bomb.green_button.on == correct_green:
		print("BOMB DEFUSED!")
		BombTimer.is_bomb_solved = true
		BombTimer.stop()
		bomb.disable()
		

func _physics_process(_delta: float) -> void:
	if BombTimer.is_bomb_solved or BombTimer.on_titlescreen:
		AudioServer.get_bus_effect(1,0).wet = 0
		return
	if BombTimer.time_left <= BombTimer.WARNING_TIME:
		AudioServer.get_bus_effect(1,0).wet = (BombTimer.WARNING_TIME-BombTimer.time_left)/BombTimer.WARNING_TIME
	else:
		AudioServer.get_bus_effect(1,0).wet = 0

#proper combination:  red off, blue on, green off

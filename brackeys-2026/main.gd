extends Node2D

#var time_left = 60.0
var correct_red = false
var correct_blue = true
var correct_green = false
var bomb_defused = false
var time_up = false

# Dialogue
func _ready():
	pass
	$AnimationPlayer.play("titlescreen_init")

var dialogue_index = 0

var dialogue = [
	{"speaker": "PERSON A", "text": "The blue light is on."},
	{"speaker": "PERSON B", "text": "No, it isn't!"},
	
	{"speaker": "PERSON A", "text": "Look at the red light. It's clearly off."},
	{"speaker": "PERSON B", "text": "The red light is ON."},
	
	{"speaker": "PERSON A", "text": "I already told you, the blue light is on."},
	{"speaker": "PERSON B", "text": "And the green light is on too."},
	
	{"speaker": "PERSON A", "text": "Don't turn the green light on."},
	{"speaker": "PERSON B", "text": "You should turn it on."},
	
	{"speaker": "PERSON A", "text": "Just leave the red light off."},
	{"speaker": "PERSON B", "text": "No. Turn the red light on."}
]

var chat_message_scene = preload("res://scenes/ChatMessage.tscn")

# Personally I think it'll be better to put the part of code which generates messages
# and scrolls into another script for phone node
# but this is a part of project structure so I leave this for you to decide
# ^ delete after read anyway
func show_dialogue():
	if dialogue_index >= dialogue.size() \
	or BombTimer.on_titlescreen:
		return
	
	var message = chat_message_scene.instantiate()
	$CanvasLayer/Phone/ChatScroll/ChatMessages.add_child(message)
	
	message.setup_message(
		dialogue[dialogue_index]["speaker"],
		dialogue[dialogue_index]["text"]
	)
	
	message.finished_typing.connect(_on_message_finished)
	
	await get_tree().process_frame
	
func _on_message_finished():
	dialogue_index += 1
	$CanvasLayer/Phone/ChatScroll.scroll_vertical = $CanvasLayer/Phone/ChatScroll.get_v_scroll_bar().max_value
	
	await get_tree().create_timer(
		randf_range(0.3,2)
	).timeout
	
	show_dialogue()

@onready var bomb = $Bomb
#in this case, red_on is bomb.red_button.on

func _input(_event):
	check_solution()

func _process(_delta):
	
	if bomb_defused or time_up:
		return
	
	#if time_left > 0:
		#time_left -= delta
	
	#if time_left <= 0:
		#time_left = 0
		#time_up = true
		
	
	if BombTimer.is_stopped() \
	and not BombTimer.is_bomb_solved \
	and not BombTimer.on_titlescreen:
		time_up = false
		print("TIME'S UP!")
	
	#var seconds = int(time_left)
	
	#move the canva according to mouse movation
	#and after game finished (bomb solved or exploded) this effect disappear
	position = MouseParallax.relative_position*3
	

func check_solution():
	if bomb_defused:
		return
	
	if bomb.red_button.on == correct_red \
	and bomb.blue_button.on == correct_blue \
	and bomb.green_button.on == correct_green:
		bomb_defused = true
		print("BOMB DEFUSED!")
		BombTimer.stop()
		BombTimer.is_bomb_solved = true
		

	
	

		
#proper combination:  red off, blue on, green off

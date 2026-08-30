extends Node2D

#var time_left = 60.0
var correct_red = false
var correct_blue = true
var correct_green = false

var correct_number = 6721
var correct_switcher = true

var slider1_upper = true
var slider2_upper = true

var correct_circuit_breaker1 = true
var correct_circuit_breaker2 = true

var time_up := false

var is_checking_solution := true

@onready var game_title: RichTextLabel = $TitleLayer/GameTitle

func _ready():
	BombTimer.on_titlescreen = true
	$AnimationPlayer.play("titlescreen_init")

# the menu buttons
func _on_start_pressed() -> void:
	$AnimationPlayer.play("titlescree_out")
	#game_title.visible = false
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
	{"speaker": "Agnes", "text": "The blue light is supposed to be on."},
	{"speaker": "Delilah", "text": "NO, it isn't!"},

	{"speaker": "Agnes", "text": "Leave the red and green lights alone!"},
	{"speaker": "Delilah", "text": "The red light started off on."},

	{"speaker": "Agnes", "text": "And you should make sure the green light is off."},
	{"speaker": "Delilah", "text": "You're wrong. Turn the green light on!!"},

	{"speaker": "Agnes", "text": "The code is 6721. Please believe me!"},
	{"speaker": "Delilah", "text": "No. It's 6712!"},

	{"speaker": "Agnes", "text": "The switch needs to be on. I promise I am not lying to you."},
	{"speaker": "Delilah", "text": "Leave the switch off."},

	{"speaker": "Agnes", "text": "Both sliders need to be above the middle."},
	{"speaker": "Delilah", "text": "No! Move both sliders to below the middle."},

	{"speaker": "Agnes", "text": "The orange switch is on."},
	{"speaker": "Delilah", "text": "It's off."},

	{"speaker": "Agnes", "text": "The purple switch is on too."},
	{"speaker": "Delilah", "text": "No, that one is off."},
]

var bomb_solved_dialogue = [
	{"speaker": "Agnes", "text": "You did it! Congradulations!"},
	{"speaker": "Delilah", "text": "Fine."},
	{"speaker": "MrEx3c98", "text": "(Press [url={'restart'}]here[/url] to reset)"}
]

var current_dialogue = dialogue

var chat_message_scene = preload("res://scenes/ChatMessage.tscn")
@onready var phone = $CanvasLayer/Phone

func show_dialogue():
	if dialogue_index >= current_dialogue.size():
		return
	
	await phone.add_dialogue(
		current_dialogue[dialogue_index]["speaker"],
		current_dialogue[dialogue_index]["text"]
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
	if is_checking_solution:
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
	
	var colors_correct = (
		bomb.red_button.on == correct_red
		and bomb.blue_button.on == correct_blue
		and bomb.green_button.on == correct_green
	)
	
	var number_correct = bomb.digital_input.number == correct_number
	
	var switcher_correct = bomb.switcher.is_toggled_on == correct_switcher
	
	var slider1_correct = bomb.slider1.pos > 0.5
	var slider2_correct = bomb.slider2.pos > 0.5
	
	var circuit_breakers_correct = (
		bomb.circuit_breaker1.on == correct_circuit_breaker1
		and bomb.circuit_breaker2.on == correct_circuit_breaker2
	)
	
	if (
		colors_correct
		and number_correct
		and switcher_correct
		and slider1_correct
		and slider2_correct
		and circuit_breakers_correct
	):
		is_checking_solution = false
		if randi_range(1,10) == 1:
			$CaptchaLayer.popup()
			return
		print("BOMB DEFUSED!")
		if dialogue_index >= current_dialogue.size():
			current_dialogue = bomb_solved_dialogue
			dialogue_index = 0
			show_dialogue()
		current_dialogue = bomb_solved_dialogue
		dialogue_index = 0
		BombTimer.is_bomb_solved = true
		BombTimer.stop()
		bomb.disable()

func _on_captcha_layer_solved() -> void:
	print("BOMB DEFUSED!")
	if dialogue_index >= current_dialogue.size():
		current_dialogue = bomb_solved_dialogue
		dialogue_index = 0
		show_dialogue()
	current_dialogue = bomb_solved_dialogue
	dialogue_index = 0
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

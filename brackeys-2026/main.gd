extends Node2D

var red_on = false
var blue_on = false
var green_on = false
var time_left = 5.0
var correct_red = false
var correct_blue = true
var correct_green = false
var bomb_defused = false
var time_up = false

# Dialogue
var dialogue_index = 0

var dialogue = [
	{"speaker": "PERSON A", "text": "The blue light is on."},
	{"speaker": "PERSON B", "text": "No, it isn't."},
	{"speaker": "PERSON A", "text": "The red light is off."},
	{"speaker": "PERSON B", "text": "The green light is on."}
]

func _on_red_light_pressed():
	red_on = !red_on
	$RedLight.text = "RED: " + ("ON" if red_on else "OFF")
	check_solution()

func _on_blue_light_pressed():
	blue_on = !blue_on
	$BlueLight.text = "BLUE: " + ("ON" if blue_on else "OFF")
	check_solution()

func _on_green_light_pressed():
	green_on = !green_on
	$GreenLight.text = "GREEN: " + ("ON" if green_on else "OFF")
	check_solution()

func _process(delta):
	if bomb_defused or time_up:
		return
	
	if time_left > 0:
		time_left -= delta
	
	if time_left <= 0:
		time_left = 0
		time_up = true
		print("TIME'S UP!")
	
	var seconds = int(time_left)
	$TimerLabel.text = "TIME: %02d" % seconds
	
func check_solution():
	if red_on == correct_red and blue_on == correct_blue and green_on == correct_green:
		bomb_defused = true
		print("BOMB DEFUSED!")
		
func _ready():
	$RedLight.text = "RED: OFF"
	$BlueLight.text = "BLUE: OFF"
	$GreenLight.text = "GREEN: OFF"
	show_dialogue()
	
func show_dialogue():
	$SpeakerLabel.text = dialogue[dialogue_index]["speaker"]
	$DialogueLabel.text = dialogue[dialogue_index]["text"]
		
#proper combination:  red off, blue on, green off

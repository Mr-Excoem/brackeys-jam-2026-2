extends Node2D

var red_on = false
var blue_on = false
var green_on = false
var time_left = 60.0
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
@onready var bomb = $Bomb
#in this case, red_on is bomb.red_button.on

#
func _on_red_light_pressed():
	pass
	#red_on = !red_on
	#$RedLight.text = "RED: " + ("ON" if red_on else "OFF")
	#check_solution()
#
func _on_blue_light_pressed():
	pass
	#blue_on = !blue_on
	#$BlueLight.text = "BLUE: " + ("ON" if blue_on else "OFF")
	#check_solution()
#
func _on_green_light_pressed():
	pass
	#green_on = !green_on
	#$GreenLight.text = "GREEN: " + ("ON" if green_on else "OFF")
	#check_solution()

func _input(_event):
	check_solution()

func _process(delta):
	
	if bomb_defused or time_up:
		return
	
	if time_left > 0:
		time_left -= delta
	
	if time_left <= 0:
		time_left = 0
		#time_up = true
		
	
	if BombTimer.is_stopped() and not BombTimer.is_bomb_solved:
		time_up = false
		print("TIME'S UP!")
	
	var seconds = int(time_left)
	
	#move the canva according to mouse movation
	#and after game finished (bomb solved or exploded) this effect disappear
	position = MouseParallax.relative_position*2
	

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

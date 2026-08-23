extends Node2D

var red_on = false
var blue_on = false
var green_on = false
var time_left = 5.0
var correct_red = false
var correct_blue = true
var correct_green = false
var bomb_defused = false

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
	if bomb_defused:
		return
	
	if time_left > 0:
		time_left -= delta
	
	if time_left < 0:
		time_left = 0
	
	var seconds = int(time_left)
	$TimerLabel.text = "TIME: %02d" % seconds
	
func check_solution():
	if red_on == correct_red and blue_on == correct_blue and green_on == correct_green:
		bomb_defused = true
		print("BOMB DEFUSED!")

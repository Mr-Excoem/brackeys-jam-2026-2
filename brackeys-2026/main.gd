extends Node2D

var red_on = false
var blue_on = false
var green_on = false

func _on_red_light_pressed():
	red_on = !red_on
	$RedLight.text = "RED: " + ("ON" if red_on else "OFF")

func _on_blue_light_pressed():
	blue_on = !blue_on
	$BlueLight.text = "BLUE: " + ("ON" if blue_on else "OFF")

func _on_green_light_pressed():
	green_on = !green_on
	$GreenLight.text = "GREEN: " + ("ON" if green_on else "OFF")

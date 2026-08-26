extends Node2D

@onready var number = $Number

func _on_increace_button_pressed() -> void:
	if number.frame < 9:
		number.frame += 1


func _on_decrease_button_pressed() -> void:
	if number.frame > 0:
		number.frame -= 1

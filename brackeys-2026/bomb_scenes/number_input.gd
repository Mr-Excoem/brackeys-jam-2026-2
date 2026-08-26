extends Node2D

signal state_changed

@onready var number = $Number

func _on_increace_button_pressed() -> void:
	if number.frame < 9:
		number.frame += 1
	state_changed.emit()


func _on_decrease_button_pressed() -> void:
	if number.frame > 0:
		number.frame -= 1
	state_changed.emit()

func disable():
	$IncreaceButton.disabled = true
	$DecreaseButton.disabled = true

func enable():
	$IncreaceButton.disabled = false
	$DecreaseButton.disabled = false

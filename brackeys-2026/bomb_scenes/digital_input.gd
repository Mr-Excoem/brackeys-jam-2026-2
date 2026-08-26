extends Node2D

@onready var n1 = $NumberInput
@onready var n2 = $NumberInput2
@onready var n3 = $NumberInput3
@onready var n4 = $NumberInput4

signal state_changed(new_number:int)

var number:int:
	get:
		return n1.number.frame*1000 \
		+ n2.number.frame*100 \
		+ n3.number.frame*10 \
		+ n4.number.frame
	set(input):
		@warning_ignore("integer_division")
		n1.number.frame = input/1000
		@warning_ignore("integer_division")
		n2.number.frame = (input%1000)/100
		@warning_ignore("integer_division")
		n3.number.frame = (input%100)/10
		n4.number.frame = input%10

func disable():
	n1.disable()
	n2.disable()
	n3.disable()
	n4.disable()

func enable():
	n1.enable()
	n2.enable()
	n3.enable()
	n4.enable()


func _on_number_state_changed() -> void:
	state_changed.emit(number)

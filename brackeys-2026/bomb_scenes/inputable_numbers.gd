extends Node2D

@onready var n1 = $NumberInput
@onready var n2 = $NumberInput2
@onready var n3 = $NumberInput3
@onready var n4 = $NumberInput4

func get_number() -> int:
	return n1.number.frame*1000 \
	+ n2.number.frame*100 \
	+ n3.number.frame*10 \
	+ n4.number.frame
	

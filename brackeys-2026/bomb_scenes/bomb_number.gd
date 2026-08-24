extends Node2D

@onready var number1 := $Number1
@onready var number2 := $Number2
@onready var number3 := $Number3
@onready var number4 := $Number4

func _ready():
	BombTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#the number displayed (0-9) can be accessed by the "frame" variable
	var time_left:int = int(BombTimer.time_left)
	@warning_ignore("integer_division")
	var minutes = (time_left-time_left%60)/60
	@warning_ignore("integer_division")
	number1.frame = (minutes-minutes%10)/10
	number2.frame = minutes%10
	var seconds = time_left%60
	@warning_ignore("integer_division")
	number3.frame = (seconds-seconds%10)/10
	number4.frame = seconds%10
	

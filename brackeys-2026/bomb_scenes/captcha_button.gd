extends Control

@onready var button := $CaptchaButton
var center:Vector2

# given by the parent node
var index:int

signal state_changed(toggled_on:bool, idx:int)

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$AnimationPlayer.play("pressed")
	else:
		$AnimationPlayer.play_backwards("pressed")
	state_changed.emit(toggled_on, index)

func _process(_delta: float) -> void:
	center = size / 2
	button.position = center - (button.size*button.scale / 2)

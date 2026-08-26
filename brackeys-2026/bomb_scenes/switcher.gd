extends Node2D

var is_toggled_on := false

func _on_button_toggled(toggled_on: bool) -> void:
	is_toggled_on = toggled_on
	if toggled_on:
		$AnimationPlayer.play("toggle_on")
	else:
		$AnimationPlayer.play_backwards("toggle_on")

func disable():
	$Button.disabled = true

func enable():
	$Button.enable = true

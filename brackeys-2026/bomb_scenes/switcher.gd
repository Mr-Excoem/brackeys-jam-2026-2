extends Node2D

signal state_changed(toggled_on: bool)

var is_toggled_on := false

func _on_button_toggled(toggled_on: bool) -> void:
	is_toggled_on = toggled_on
	state_changed.emit(is_toggled_on)
	if toggled_on:
		$AnimationPlayer.play("toggle_on")
	else:
		$AnimationPlayer.play_backwards("toggle_on")

func disable():
	$Button.disabled = true

func enable():
	$Button.enable = true

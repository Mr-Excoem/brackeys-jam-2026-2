extends AnimatedSprite2D

const DOWN = Vector2(-7.5,-3.0)
const UP = Vector2(-7.5,-9.0)

var on := false
signal state_changed(toggled_on:bool)

@onready var button := $Button

func _on_button_toggled(toggled_on: bool) -> void:
	disable()
	on = toggled_on
	if toggled_on:
		play("pull_up")
		button.position = UP
	else:
		play_backwards("pull_up")
		button.position = DOWN
	state_changed.emit(on)
	await animation_finished
	enable()

func disable():
	button.disabled = true

func enable():
	button.disabled = false

extends CanvasLayer

signal solved

@onready var captcha = $HumanVeritification

func _process(_delta):
	if BombTimer.is_bomb_solved:
		return
	offset = MouseParallax.relative_position*6

func popup():
	$AnimationPlayer.play("popup")


func _on_button_pressed() -> void:
	captcha.enable()
	await captcha.solved
	$HumanVeritificationPopup/Button.disabled = true
	$HumanVeritificationPopup/Tickmark.show()
	await get_tree().create_timer(0.2).timeout
	$AnimationPlayer.play_backwards("popup")
	solved.emit()

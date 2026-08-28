extends Node2D

signal solved

var solution = PackedInt32Array([
	0, 1, 1, 0,
	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,
])

var situation = PackedInt32Array([
	0, 0, 0, 0,
	0, 0, 0, 0,
	0, 0, 0, 0,
	0, 0, 0, 0,
])

func enable():
	$AnimationPlayer.play("popup")

func _on_any_button_pressed(state:bool, index:int) -> void:
	situation[index] = int(state)
	if situation == solution:
		solved.emit()
		$AnimationPlayer.play_backwards("popup")
		await $AnimationPlayer.animation_finished
		visible = false

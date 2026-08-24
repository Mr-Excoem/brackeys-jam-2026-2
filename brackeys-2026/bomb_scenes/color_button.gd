extends TextureButton

var lighting := false


func _on_pressed() -> void:
	if lighting:
		modulate = Color.WHITE.darkened(0.4)
		lighting = false
	else:
		modulate = Color.WHITE.lightened(0.4)
		lighting = true

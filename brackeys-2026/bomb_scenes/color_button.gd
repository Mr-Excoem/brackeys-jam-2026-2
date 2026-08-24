extends TextureButton

var on := false

func _ready():
	modulate = Color.WHITE.darkened(0.4)

func _on_pressed() -> void:
	if on:
		modulate = Color.WHITE.darkened(0.4)
		on = false
	else:
		modulate = Color.WHITE.lightened(0.4)
		on = true

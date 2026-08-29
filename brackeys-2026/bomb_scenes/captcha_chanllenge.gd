extends GridContainer

@export var chanllenge_pic:SpriteFrames
const ANIMATION = "default"

#var button = preload("uid://8yp4hl3hteiy")

func _ready() -> void:
	for idx in chanllenge_pic.get_frame_count(ANIMATION):
		#var button_instance := button.instantiate()
		var texture := chanllenge_pic.get_frame_texture(ANIMATION, idx)
		#button_instance.state_changed.connect(get_parent()._on_any_button_pressed)
		#button_instance.index = idx
		
		#add_child(button_instance)
		#button_instance.button.texture_normal = texture

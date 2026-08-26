extends Sprite2D

@onready var red_button = $ColorButtons/Red
@onready var green_button = $ColorButtons/Green
@onready var blue_button = $ColorButtons/Blue

# access the digital input via bomb.digital_input.number
# there's also functions like bomb.digital_input.disable() and bomb.digital_input.enable() available
@onready var digital_input = $DigitalInput

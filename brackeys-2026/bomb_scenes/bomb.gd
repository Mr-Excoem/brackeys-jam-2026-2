extends Sprite2D

@onready var red_button = $ColorButtons/Red
@onready var green_button = $ColorButtons/Green
@onready var blue_button = $ColorButtons/Blue

# access the digital input via bomb.digital_input.number
# there's also functions like bomb.digital_input.enable() and bomb.digital_input.disable() available
@onready var digital_input = $DigitalInput

# bomb.switcher.is_toggled_on
# and enable() & disable() as usual
@onready var switcher = $Switcher

# bomb.slider*.pos (from 0 to 1)
@onready var slider1 = $Slider
@onready var slider2 = $Slider2

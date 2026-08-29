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

# bomb.circuit_breaker*.on
@onready var circuit_breaker1 = $CircuitBreaker
@onready var circuit_breaker2 = $CircuitBreaker2

func disable():
	red_button.disabled = true
	green_button.disabled = true
	blue_button.disabled = true
	digital_input.disable()
	switcher.disable()
	slider1.disable()
	slider2.disable()
	circuit_breaker1.disable()
	circuit_breaker2.disable()


func enable():
	BombTimer.start(BombTimer.TIME)
	$Tick.play()
	red_button.disabled = false
	green_button.disabled = false
	blue_button.disabled = false
	digital_input.enable()
	switcher.enable()
	slider1.enable()
	slider2.enable()
	circuit_breaker1.enable()
	circuit_breaker2.enable()

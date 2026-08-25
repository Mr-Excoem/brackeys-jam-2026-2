extends RichTextLabel

signal finished_typing

var speaker = ""

var full_text = ""
var word_index = 0
var words = []
var typing_speed = 0.07
var typing_timer = 0.0
var typing_finished = false


func setup_message(new_speaker: String, new_text: String):
	speaker = new_speaker
	full_text = new_text
	words = full_text.split(" ")
	word_index = 0
	typing_finished = false
	typing_timer = 0.0
	
	if speaker == "PERSON A":
		horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	else:
		horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	
	text = ""


func _process(delta):
	if typing_finished:
		return
	
	typing_timer += delta
	
	if typing_timer >= typing_speed:
		typing_timer = 0
		word_index += 1
		
		if word_index >= words.size():
			text = full_text
			typing_finished = true
			finished_typing.emit()
		else:
			text = " ".join(words.slice(0, word_index))

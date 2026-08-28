extends Node2D

var chat_message_scene = preload("uid://b8embku2jpi8")
@onready var chat_scroll = $ChatScroll

func add_dialogue(speaker:String, text:String) -> Signal:
	# In theory this function won't be called during titlescreen
	# but there's an old Chinese saying says 不怕一万，就怕万一
	if BombTimer.on_titlescreen:
		return Signal()
	
	var message = chat_message_scene.instantiate()
	$ChatScroll/ChatMessages.add_child(message)
	message.setup_message(speaker, text)
	return message.finished_typing

func _process(_delta):
	chat_scroll.scroll_vertical = chat_scroll.get_v_scroll_bar().max_value
		

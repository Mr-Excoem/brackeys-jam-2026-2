extends Node2D

var chat_message_scene = preload("res://scenes/ChatMessage.tscn")
@onready var chat_scroll = $ChatScroll

func add_dialogue(speaker:String, text:String):
	# In theory this function won't be called during titlescreen
	# but there's an old Chinese saying says 不怕一万，就怕万一
	if BombTimer.on_titlescreen:
		return
	
	var message = chat_message_scene.instantiate()
	$ChatScroll/ChatMessages.add_child(message)
	message.setup_message(speaker, text)
	await message.finished_typing

func _process(_delta):
	# BUG maybe: this will lead to displaying the best animation 
	# but stop players from scrolling the phone
	chat_scroll.scroll_vertical = chat_scroll.get_v_scroll_bar().max_value

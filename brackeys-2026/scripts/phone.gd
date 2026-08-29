extends Node2D

@onready var chat_scroll = $ChatScroll
const chat_message_scene = preload("res://scenes/ChatMessage.tscn")



func add_dialogue(speaker: String, text: String):
	if BombTimer.on_titlescreen:
		return
	
	var message = chat_message_scene.instantiate()
	$ChatScroll/ChatMessages.add_child(message)
	message.setup_message(speaker, text)
	
	await message.finished_typing
	
	await get_tree().process_frame
	chat_scroll.scroll_vertical = chat_scroll.get_v_scroll_bar().max_value

extends Node

@onready var chat_scroll: ScrollContainer = $ChatScroll
const chat_message_scene = preload("uid://b8embku2jpi8")


func add_dialogue(speaker: String, text: String):
	if BombTimer.on_titlescreen:
		return
	
	var message:RichTextLabel = chat_message_scene.instantiate()
	$ChatScroll/ChatMessages.add_child(message)
	message.meta_clicked.connect(restart)
	message.setup_message(speaker, text)
	
	await message.finished_typing

func _process(_delta):
	@warning_ignore("narrowing_conversion")
	chat_scroll.scroll_vertical = chat_scroll.get_v_scroll_bar().max_value

func restart(_meta):
	get_tree().reload_current_scene()

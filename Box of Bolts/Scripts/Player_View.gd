extends Node

signal press_up

onready var label = $Label


func _process(delta):
	if(Input.is_action_just_pressed("ui_up")):
		emit_signal("press_up")


func update_label(text):
	label.set_text(str(text))
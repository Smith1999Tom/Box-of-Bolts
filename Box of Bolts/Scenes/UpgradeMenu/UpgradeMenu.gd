extends Node

signal changeMenu_Main

var main = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	connect("changeMenu_Main", main, "_on_changeMenu_Main")

func init(MainReference):
	main = MainReference

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackBtn_pressed():
	emit_signal("changeMenu_Main")
	pass # Replace with function body.


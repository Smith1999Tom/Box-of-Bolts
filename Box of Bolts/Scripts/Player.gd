extends Node

onready var model = $Model
onready var view = $View

func _ready():
	pass

func _on_View_press_up():
	var health = model.reduce_health(10)
	view.update_label(health)
	

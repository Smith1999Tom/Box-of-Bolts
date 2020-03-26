extends Node

#Define model and view child nodes
onready var model = $Model
onready var view = $View

func _ready():
	view.move_to(Vector2(200, 200))
	
	pass

func _on_View_press_up():
	var health = model.reduce_health(10)
	view.update_label(health)
	



func _on_View_press_left():
	if(!model.get_moving()):
		model.set_moving(true)
		view.move(-50)
		yield(get_tree().create_timer(1), "timeout")
		model.set_moving(false)


func _on_View_press_right():
	if(!model.get_moving()):
		model.set_moving(true)
		view.move(50)
		yield(get_tree().create_timer(1), "timeout")
		model.set_moving(false)

extends Area2D

signal press_up
signal press_left
signal press_right

onready var label = $Label

func _ready():
	$AnimatedSprite.play()

func _process(delta):
	if(Input.is_action_just_pressed("ui_up")):
		emit_signal("press_up")
	if(Input.is_action_just_pressed("ui_left")):
		emit_signal("press_left")
	if(Input.is_action_just_pressed("ui_right")):
		emit_signal("press_right")


func update_label(text):
	label.set_text(str(text))

func move_to(newPos):
	position = newPos
	
func move(distance):
	position.x += distance

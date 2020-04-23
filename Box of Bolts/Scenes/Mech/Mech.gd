extends Node2D

class_name Mech

export var stepForwardDistance = 1280*0.125
export var stepForwardSpeed = 1.0
export var stepBackwardSpeed = 0.7
var direction = 1

var screenpos
var state = "Idle"
onready var arena = get_parent()
var scaleFactor = 1

var enemy

func ready():
	$AnimatedSprite.play("Idle")
	
func init(aScale, enemyRef):
	scaleFactor = aScale
	enemy = enemyRef
	pass

func _process(delta):
	if(state == "StepForward"):
		self.position.x += ((stepForwardDistance * delta * stepForwardSpeed * direction)/ scaleFactor)
	if(state == "StepBackward"):
		self.position.x -= ((stepForwardDistance * delta * stepBackwardSpeed * direction) / scaleFactor)
	pass	

func stepForward():
	$AnimatedSprite.speed_scale = stepForwardSpeed*2
	$AnimatedSprite.play("StepForward")
	state = "StepForward"


func _on_AnimatedSprite_animation_finished():
	#print("DEBUG animation stop")
	if(state == "StepBackward"):
		arena.stop_stage()
	state = "Idle"
	$AnimatedSprite.speed_scale = 1
	$AnimatedSprite.play("Idle")
	
	
func stepBackward():
	print("ERROR - Called mech.stepBackward instead of a player or enemy stepBackward.")
	pass

extends Mech

export var stepForwardDistance = 1280*0.125
export var stepForwardSpeed = 1.0
export var stepBackwardSpeed = 0.7

var screenpos
var state = "Idle"
onready var arena = get_parent()

signal slideLeft
signal slideRight


func _ready():
	$AnimatedSprite.play("Idle")
	write_health()
	screenpos = get_viewport_rect().size
	position.x = 1280*0.25
	
	pass
		
	
func _process(delta):
	if(state == "StepForward"):
		self.position.x += (stepForwardDistance * delta * stepForwardSpeed)
	if(state == "StepBackward"):
		self.position.x -= (stepForwardDistance * delta * stepBackwardSpeed)
	pass	
	
func write_health():
	print(self.health)

func rPunch():
	$AnimatedSprite.play("RPunch")
	
func stepForward():
	$AnimatedSprite.speed_scale = stepForwardSpeed*2
	$AnimatedSprite.play("StepForward")
	state = "StepForward"
	#self.position.x += stepForwardDistance
	
func stepBackward():
	$AnimatedSprite.speed_scale = stepBackwardSpeed*2
	$AnimatedSprite.play("StepForward")	#TODO Implement backward animation
	state = "StepBackward"
	if(position.x <= arena.leftBoundary + 400):
		#camera.slide_left()
		arena.slide_stage_left()
		pass

func _on_AnimatedSprite_animation_finished():
	state = "Idle"
	$AnimatedSprite.speed_scale = 1
	$AnimatedSprite.play("Idle")

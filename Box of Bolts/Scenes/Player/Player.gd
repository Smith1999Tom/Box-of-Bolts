extends Mech

export var stepForwardDistance = 1280*0.125
export var stepForwardSpeed = 1.0
export var stepBackwardSpeed = 0.7
var direction = 1

var screenpos
var state = "Idle"
onready var arena = get_parent()
var scaleFactor = 1

var enemy


signal slideLeft
signal slideRight


func _ready():
	$AnimatedSprite.play("Idle")
	write_health()
	screenpos = get_viewport_rect().size
	position.x = 1280*0.25
	pass
	
func init(aScale, enemyRef):
	scaleFactor = aScale
	enemy = enemyRef
	pass
		
	
func _process(delta):
	if(state == "StepForward"):
		self.position.x += ((stepForwardDistance * delta * stepForwardSpeed)/ scaleFactor)
	if(state == "StepBackward"):
		self.position.x -= ((stepForwardDistance * delta * stepBackwardSpeed) / scaleFactor)
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
	var shouldMove = false
	
	if(position.x >= arena.leftBoundary + 400):
		shouldMove = true
	elif((position.x <= arena.leftBoundary + 400) && (enemy.position.x <= arena.rightBoundary - 400)):
		arena.slide_stage_left()
		shouldMove = true
	
	if(shouldMove):
		$AnimatedSprite.speed_scale = stepBackwardSpeed*2
		$AnimatedSprite.play("StepForward")	#TODO Implement backward animation
		state = "StepBackward"
		
		
func _on_AnimatedSprite_animation_finished():
	state = "Idle"
	$AnimatedSprite.speed_scale = 1
	$AnimatedSprite.play("Idle")

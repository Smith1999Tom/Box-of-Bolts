extends Mech



func _ready():
	stepForwardDistance = 1280*0.125
	stepForwardSpeed = 1.0
	stepBackwardSpeed = 0.7
	direction = 1
	
	#$AnimatedSprite.play("Idle")
	screenpos = get_viewport_rect().size
	position.x = 1280*0.25
	pass
	
	



	
	

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
		
		


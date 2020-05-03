extends Mech



func _ready():
	._ready()
	direction = 1
	
	#$AnimatedSprite.play("Idle")
	screenpos = get_viewport_rect().size
	position.x = 1280*0.25
	oldpos = position
	pass
	
	



	
	

	#self.position.x += stepForwardDistance

func lPunch():
	.lPunch()
	$AnimatedSprite.offset = Vector2(20, 0)	

	
func stepBackward():
	var shouldMove = false
	
	if(position.x > arena.leftBoundary + 320):
		shouldMove = true
	elif((position.x <= arena.leftBoundary + 320) && (enemy.position.x < arena.rightBoundary - 320)):
		arena.slide_stage_left()
		shouldMove = true
	
	if(shouldMove):
		$AnimatedSprite.speed_scale = stepBackwardSpeed*2
		$AnimatedSprite.play("StepForward")	#TODO Implement backward animation
		state = "StepBackward"
		
		


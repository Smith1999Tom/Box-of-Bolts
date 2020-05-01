extends Mech

signal getNewCommand

var ai

func _ready():
	$AnimatedSprite.play("Idle")
	$AnimatedSprite.set_flip_h(true)
	screenpos = get_viewport_rect().size
	#position.x = screenpos.x*0.75
	position.x = 1280*0.75
	oldpos = position
	direction = -1
	ai = arena.main.ai
	self.connect("getNewCommand", ai, "generateCommand")
	emit_signal("getNewCommand")
	
	pass

func stepBackward():
	var shouldMove = false
	
	if(position.x <= arena.rightBoundary - 400):
		shouldMove = true
	elif((position.x >= arena.rightBoundary - 400) && (enemy.position.x >= arena.leftBoundary + 400)):
		arena.slide_stage_right()
		shouldMove = true
	
	if(shouldMove):
		$AnimatedSprite.speed_scale = stepBackwardSpeed*2
		$AnimatedSprite.play("StepForward")	#TODO Implement backward animation
		state = "StepBackward"
		
func _on_AnimatedSprite_animation_finished():
	._on_AnimatedSprite_animation_finished()
	emit_signal("getNewCommand")
	pass


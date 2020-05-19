extends Mech

signal getNewCommand

var ai
var difficulty = 50

func _ready():
	._ready()
	$AnimatedSprite.play("Idle")
	$AnimatedSprite.set_flip_h(true)
	screenpos = get_viewport_rect().size
	#position.x = screenpos.x*0.75
	position.x = 1280*0.75
	oldpos.x = position.x
	direction = -1
	ai = arena.main.ai
	self.connect("getNewCommand", ai, "generateCommand")
	#emit_signal("getNewCommand")
	
	pass

func _process(delta):
	if(state == "Countdown"):
		return
	if(state == "Idle" or state == "Block"):
		emit_signal("getNewCommand")

func stepBackward():
	if(state == "Block"):
		end_block()
	var shouldMove = false
	if(state != "Idle" or stunTimeRemaining > 0):
		return
	
	if(position.x <= arena.rightBoundary - 400):
		shouldMove = true
	elif((position.x >= arena.rightBoundary - 400) && (enemy.position.x >= arena.leftBoundary + 400)):
		arena.slide_stage_right()
		shouldMove = true
	
	if(shouldMove):
		$AnimatedSprite.speed_scale = stepBackwardSpeed*2
		$AnimatedSprite.play("StepForward")	#TODO Implement backward animation
		state = "StepBackward"
		.stepBackward()
		
func idle():
	.idle()
	$AnimatedSprite.speed_scale = 1
		
		
func _on_AnimatedSprite_animation_finished():
	._on_AnimatedSprite_animation_finished()
	pass


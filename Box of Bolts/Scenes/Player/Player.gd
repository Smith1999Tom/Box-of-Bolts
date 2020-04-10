extends Mech

export var stepForwardDistance = 100
var screenpos
var state = "Idle"

func _ready():
	$AnimatedSprite.play("Idle")
	write_health()
	screenpos = get_viewport_rect().size
	position.x = screenpos.x/4
	pass
	
func write_health():
	print(self.health)

func rPunch():
	$AnimatedSprite.play("RPunch")
	
func stepForward():
	$AnimatedSprite.play("StepForward")
	state = "StepForward"
	#self.position.x += stepForwardDistance


func _on_AnimatedSprite_animation_finished():
	if(state == "StepForward"):
		self.position.x += stepForwardDistance
		state = "Idle"
	$AnimatedSprite.play("Idle")

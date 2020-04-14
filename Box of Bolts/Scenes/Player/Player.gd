extends Mech

export var stepForwardDistance = 1280*0.125
export var stepForwardSpeed = 1.0

var screenpos
var state = "Idle"


func _ready():
	$AnimatedSprite.play("Idle")
	write_health()
	screenpos = get_viewport_rect().size
	position.x = 1280*0.25
	
	pass
		
	
func _process(delta):
	if(state == "StepForward"):
		self.position.x += (stepForwardDistance * delta * stepForwardSpeed)
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


func _on_AnimatedSprite_animation_finished():
	state = "Idle"
	$AnimatedSprite.speed_scale = 1
	$AnimatedSprite.play("Idle")

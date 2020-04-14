extends Mech
var screenpos

func _ready():
	$AnimatedSprite.play()
	$AnimatedSprite.set_flip_h(true)
	write_health()
	screenpos = get_viewport_rect().size
	#position.x = screenpos.x*0.75
	position.x = 1280*0.75
	pass
	
func write_health():
	print(self.health)
	
func moveForward():
	$AnimatedSprite.play("StepForward")


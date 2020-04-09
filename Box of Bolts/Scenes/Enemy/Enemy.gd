extends Mech

func _ready():
	$AnimatedSprite.play()
	$AnimatedSprite.set_flip_h(true)
	write_health()
	pass
	
func write_health():
	print(self.health)


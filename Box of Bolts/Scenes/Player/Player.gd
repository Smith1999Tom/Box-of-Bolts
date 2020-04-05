extends Mech

func _ready():
	$AnimatedSprite.play()
	write_health()
	pass
	
func write_health():
	print(self.health)


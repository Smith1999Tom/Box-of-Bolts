extends Mech

func _ready():
	$AnimatedSprite.play("Idle")
	write_health()
	pass
	
func write_health():
	print(self.health)

func rPunch():
	$AnimatedSprite.play("RPunch")


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("Idle")

extends Node2D

class_name Mech

export var stepForwardDistance = 120
export var stepForwardSpeed = 1.0
export var stepBackwardSpeed = 0.7

var health = 100
var stamina = 100

var hitFrame = 11	#The frame of animation that hits will be checked on
var baseStunTime = 1.0

var direction = 1
var oldpos = Vector2(0,0)

var screenpos
var state = "Idle"
onready var arena = get_parent()
var scaleFactor = 1

var main
var enemy

func ready():
	$AnimatedSprite.play("Idle")
	
func init(aScale, enemyRef, mainRef):
	scaleFactor = aScale
	enemy = enemyRef
	main = mainRef
	pass

func _process(delta):
	if(state == "StepForward"):
		self.position.x += ((stepForwardDistance * delta * stepForwardSpeed * direction)/ scaleFactor)
	if(state == "StepBackward"):
		self.position.x -= ((stepForwardDistance * delta * stepBackwardSpeed * direction) / scaleFactor)
	if(state == "LeftPunch"):
		if($AnimatedSprite.frame == hitFrame):
			var distanceBetweenMechs = abs(self.position.x - enemy.position.x)
			if distanceBetweenMechs <= 400:
				enemy.getHit()
	pass	

func idle():
	state = "Idle"
	$AnimatedSprite.offset = Vector2(0, 0)
	$AnimatedSprite.speed_scale = 1
	$AnimatedSprite.play("Idle")
	

func stepForward():
	if(state != "Idle"):
		return
	$AnimatedSprite.speed_scale = stepForwardSpeed*2
	$AnimatedSprite.play("StepForward")
	state = "StepForward"

func lPunch():
	if(state != "Idle"):
		return
	$AnimatedSprite.offset = Vector2(44 * direction, 4)	
	#$AnimatedSprite.speed_scale = 1.5
	$AnimatedSprite.play("LPunch")
	state = "LeftPunch"
	

func rPunch():
	if(state != "Idle"):
		return
	$AnimatedSprite.offset = Vector2(20 * direction, 0)	
	#$AnimatedSprite.speed_scale = 1.5
	$AnimatedSprite.play("RPunch")
	state = "RightPunch"

func _on_AnimatedSprite_animation_finished():
	#print("DEBUG: " + self.name + " animation stop")
	if(state == "Block" or state == "Hit"):
		return
	if(state == "StepForward"):
		position.x = oldpos.x + (stepForwardDistance * direction)
		oldpos.x = position.x
	if(state == "StepBackward"):
		position.x = oldpos.x - (stepForwardDistance * direction)
		oldpos.x = position.x
		arena.stop_stage()
	idle()
	
func block():
	if(state != "Idle"):
		return
	print("DEBUG: " + self.name + " is blocking")
	state = "Block"
	$AnimatedSprite.play("Block")
	
func end_block():
	print("DEBUG: " + self.name + " has stopped blocking")
	state = "Idle"
	$AnimatedSprite.play("Idle")
	
func getHit():
	if(state != "Hit" && state != "Block"):
		state = "Hit"
		$AnimatedSprite.play("Hit")
		print("DEBUG: " + self.name + " got hit")
		var timer = Timer.new()
		timer.one_shot = true
		timer.connect("timeout", self, "endHit")
		add_child(timer)
		timer.start(baseStunTime)
		main.shake_camera()
	
func endHit():
	state = "Idle"
	$AnimatedSprite.play("Idle")
	
func stepBackward():
	print("ERROR - Called mech.stepBackward instead of a player or enemy stepBackward.")
	pass
	
func reduceStamina(amount):
	stamina -= amount
	if stamina < 0:
		stamina = 0
	
	
func getDistanceBetweenMechs():
	return abs(self.position.x - enemy.position.x)

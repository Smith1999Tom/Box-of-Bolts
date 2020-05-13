extends Node2D

class_name Mech

signal onHit(name, value)
signal onAction(name, value)

export var stepForwardDistance = 120
export var stepForwardSpeed = 1.0
export var stepBackwardSpeed = 0.7

var max_health = 100
var max_energy = 100
var health = max_health
var energy = max_energy


var lPunchEnergy = 20
var rPunchEnergy = 40
var lPunchDamage = 5
var rPunchDamage = 15

var energyCooldown = 3.0
var energyCooldownRemaining = 0.0

var lPunchHitFrame = 11	#The frame of animation that hits will be checked on
var rPunchHitFrame = 26
var hitCooldown = 0.3
var hitCooldownRemaining = 0.0
var baseStunTime = 2.0
var stunTimeRemaining = 0.0

var direction = 1
var oldpos = Vector2(0,0)

var screenpos
var state = "Countdown"
var arena
var scaleFactor = 1

var main
var enemy

func _ready():
	$AnimatedSprite.play("Idle")
	arena = get_parent()
	
	
func init(aScale, enemyRef, mainRef):
	
	scaleFactor = aScale
	enemy = enemyRef
	main = mainRef
	connect("onHit", arena.gui, "onHit")
	connect("onAction", arena.gui, "onAction")
	pass

func _process(delta):
	if(state == "Countdown"):
		return
	var rechargeFactor = 1.0
	if(state == "StepForward"):
		self.position.x += ((stepForwardDistance * delta * stepForwardSpeed * direction))
		rechargeFactor = 0.2
	if(state == "StepBackward"):
		self.position.x -= ((stepForwardDistance * delta * stepBackwardSpeed * direction))
		rechargeFactor = 0.2
	if(state == "LeftPunch"):
		rechargeFactor = 0.2
		if($AnimatedSprite.frame == lPunchHitFrame):
			var distanceBetweenMechs = abs(self.position.x - enemy.position.x)
			if distanceBetweenMechs <= 400:
				enemy.getHit(lPunchDamage)
	if(state == "RightPunch"):
		rechargeFactor = 0.2
		if($AnimatedSprite.frame == rPunchHitFrame):
			var distanceBetweenMechs = abs(self.position.x - enemy.position.x)
			if distanceBetweenMechs <= 400:
				enemy.getHit(rPunchDamage)
	if(state == "Hit"):
		if(hitCooldownRemaining > 0):
			hitCooldownRemaining -= delta
		else:
			hitCooldownRemaining = 0	
		if(stunTimeRemaining > 0):
			stunTimeRemaining -= delta
		else:
			stunTimeRemaining = 0
			idle()
	if(state == "Block"):
		rechargeFactor = 0.2
		
	
				
	if(energyCooldownRemaining <= 0):
		rechargeEnergy(delta, rechargeFactor)
	else:
		energyCooldownRemaining -= 1 * delta
	pass	

func idle():
	state = "Idle"
	$AnimatedSprite.offset = Vector2(0, 0)
	$AnimatedSprite.speed_scale = 1
	$AnimatedSprite.play("Idle")
	

func stepForward():
	
	if(state != "Idle" and state != "Block" or state == "Countdown"):
		return
	end_block()
	$AnimatedSprite.speed_scale = stepForwardSpeed*2
	$AnimatedSprite.play("StepForward")
	state = "StepForward"
	reduceEnergy(0, 1)

func lPunch():
	
	if((state != "Idle" and state != "Block") or energy < lPunchEnergy or state == "Countdown"):
		return
	end_block()
	reduceEnergy(lPunchEnergy * -1, 1)
	$AnimatedSprite.offset = Vector2(44 * direction, 4)	
	#$AnimatedSprite.speed_scale = 1.5
	$AnimatedSprite.play("LPunch")
	state = "LeftPunch"
	

func rPunch():
	
	if((state != "Idle" and state != "Block") or energy < rPunchEnergy or state == "Countdown"):
		return
	end_block()
	reduceEnergy(rPunchEnergy * -1, 1)
	$AnimatedSprite.offset = Vector2(20 * direction, 0)	
	#$AnimatedSprite.speed_scale = 1.5
	$AnimatedSprite.play("RPunch")
	state = "RightPunch"

func _on_AnimatedSprite_animation_finished():
	#print("DEBUG: " + self.name + " animation stop")
	if(state == "Block" or state == "Hit" or state == "Countdown"):
		return
	if(state == "StepForward"):
		position.x = oldpos.x + (stepForwardDistance * direction)
		oldpos.x = position.x
	if(state == "StepBackward"):
		position.x = oldpos.x - (stepForwardDistance * direction)
		oldpos.x = position.x
		#arena.stop_stage()
	idle()
	
func block():
	if(state != "Idle" or state == "Countdown"):
		return
	print("DEBUG: " + self.name + " is blocking")
	state = "Block"
	$AnimatedSprite.play("Block")
	
func end_block():
	if(state == "Countdown"):
		return
	print("DEBUG: " + self.name + " has stopped blocking")
	state = "Idle"
	$AnimatedSprite.play("Idle")
	
func getHit(damage):
	if(state != "Block" and hitCooldownRemaining == 0):
		state = "Hit"
		hitCooldownRemaining = hitCooldown
		emit_signal("onHit", self.name, self.health-damage)
		self.health -= damage
		$AnimatedSprite.play("Hit")
		print("DEBUG: " + self.name + " got hit")
		stunTimeRemaining = baseStunTime
		main.shake_camera()
	
func endHit():
	state = "Idle"
	$AnimatedSprite.play("Idle")
	
func stepBackward():
	#print("ERROR - Called mech.stepBackward instead of a player or enemy stepBackward.")
	reduceEnergy(0, 1)
	pass
	
func reduceEnergy(amount, cooldownFactor):
	energyCooldownRemaining = energyCooldown * cooldownFactor
	energy += amount
	if energy < 0:
		energy = 0
	emit_signal("onAction", self.name, energy)
		
func rechargeEnergy(delta, rechargeFactor):
	energy += 50 * delta * rechargeFactor
	if energy >= max_energy:
		energy = max_energy
	else:
		emit_signal("onAction", self.name, energy)
	pass
	
	
func getDistanceBetweenMechs():
	return abs(self.position.x - enemy.position.x)

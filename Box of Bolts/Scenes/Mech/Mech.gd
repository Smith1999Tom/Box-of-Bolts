extends Node2D

class_name Mech

var health = null
var energy


# Called when the node enters the scene tree for the first time.
func _ready():
	if(health == null):
		health = 100
	energy = 100
	pass # Replace with function body.

func set_health(aHealth):
	health = aHealth
	
func set_energy(aEnergy):
	energy = aEnergy
	
func step_back():
	print("Stepping back")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

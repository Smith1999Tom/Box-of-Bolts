extends Node

var health = 100
var moving = false
var attacking = false

func reduce_health(amount):
	health -= amount
	return health

func get_moving():
	return moving
	
func set_moving(val):
	moving = val
	


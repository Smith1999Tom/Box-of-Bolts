extends Node

var health = 100
var moving = false
var attacking = false

func reduce_health(amount: int):
	health -= amount
	return health

func get_moving():
	return moving
	
func set_moving(val: bool):
	moving = val
	


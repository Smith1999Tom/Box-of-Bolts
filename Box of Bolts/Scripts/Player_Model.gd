extends Node

var health = 100

func reduce_health(amount):
	health -= amount
	return health

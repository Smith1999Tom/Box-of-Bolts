extends Node

var main = null
var command = null
var enemy = null

func _ready():
	pass
	
func init(mainRef, commandRef, enemyRef):
	main = mainRef
	command = commandRef
	enemy = enemyRef
	pass

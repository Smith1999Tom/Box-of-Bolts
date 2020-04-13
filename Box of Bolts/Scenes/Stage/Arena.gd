extends Node2D
onready var root = get_tree().get_root()

var main = null
var player = null
var enemy = null

func _ready():
	self.scale = main.viewScalingFactor
	main.arena_camera()
	
	pass
	
func init(mainRef):
	main = mainRef
	
	player = main.get_player_reference()
	#player.scale = main.viewScalingFactor
	enemy = main.get_enemy_reference()
	
	call_deferred("add_child", player)
	call_deferred("add_child", enemy)

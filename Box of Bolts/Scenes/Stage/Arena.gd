extends Node2D
onready var root = get_tree().get_root()

var main = null
var player = null
var enemy = null

func _ready():
	self.scale = main.get_view_scaling_factor()
	main.move_camera_to_bottom()
	
	pass
	
func init(mainRef):
	main = mainRef
	
	player = main.get_player_reference()
	#player.scale = main.viewScalingFactor
	enemy = main.get_enemy_reference()
	
	call_deferred("add_child", player)
	call_deferred("add_child", enemy)

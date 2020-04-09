extends CanvasLayer
onready var root = get_tree().get_root()

var main = null
var player = null
var enemy = null

func _ready():
	pass
	
func init(mainRef):
	main = mainRef
	
	player = main.get_player_reference()
	enemy = main.get_enemy_reference()
	
	call_deferred("add_child", player)
	call_deferred("add_child", enemy)

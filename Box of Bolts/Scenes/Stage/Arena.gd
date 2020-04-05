extends CanvasLayer
onready var root = get_tree().get_root()

var player = null

func _ready():
	pass
	
func init(playerRef):
	player = playerRef
	call_deferred("add_child", player)

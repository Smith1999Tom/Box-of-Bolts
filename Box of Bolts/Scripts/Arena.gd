extends CanvasLayer

const playerRes = preload("res://Scenes/Player.tscn")
var player

func _ready():
	load_player()
	pass

func load_player():
	player = playerRes.instance()
	add_child(player)
	player.set_position(Vector2(200, 200))
	

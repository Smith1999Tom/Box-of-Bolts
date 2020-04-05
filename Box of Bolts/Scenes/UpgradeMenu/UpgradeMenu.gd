extends Node

signal changeMenu_Main

var main = null
var player = null

onready var root = get_tree().get_root()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	connect("changeMenu_Main", main, "_on_changeMenu_Main")

func init(MainRef, PlayerRef):
	main = MainRef
	player = PlayerRef

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackBtn_pressed():
	emit_signal("changeMenu_Main")
	root.call_deferred("remove_child", self)
	pass # Replace with function body.



func _on_CountBtn_pressed():
	var result = int($CountLbl.text)
	result += 1
	$CountLbl.text = str(result)
	player.set_health(100 + (result*10))
	#add_child(player)

extends Node2D

signal changeMenu_Main

const Stage = preload("res://Scenes/Stage/Arena.tscn")

var main = null
var stage = null
var player = null

onready var root = get_tree().get_root()

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("changeMenu_Main", main, "_on_changeMenu_Main")
	stage = Stage.instance()

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


func _on_StartBtn_pressed():
	root.call_deferred("add_child", stage)
	stage.init(main)
	#main.unload_menus()
	root.call_deferred("remove_child", self)
	

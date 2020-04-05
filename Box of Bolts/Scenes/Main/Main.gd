extends Node

const AI = preload("res://Scenes/AI/AI.tscn")
const Command = preload("res://Scenes/Command/Command.tscn")
const MainMenu = preload("res://Scenes/MainMenu/MainMenu.tscn")
const UpgradeMenu = preload("res://Scenes/UpgradeMenu/UpgradeMenu.tscn")
const LeagueMenu = preload("res://Scenes/LeagueMenu/LeagueMenu.tscn")
const Player = preload("res://Scenes/Player/Player.tscn")

onready var root = get_tree().get_root()

var ai = null
var command = null
var upgradeMenu = null
var leagueMenu = null
var mainMenu = null
var player = null

func _ready():
	ai = AI.instance()
	command = Command.instance()
	mainMenu = MainMenu.instance()
	upgradeMenu = UpgradeMenu.instance()
	leagueMenu = LeagueMenu.instance()
	player = Player.instance()
	
	player.set_name("player")
	
	mainMenu.init(self)
	leagueMenu.init(self, player)
	upgradeMenu.init(self, player)
	
	
	
	root.call_deferred("add_child", ai)
	root.call_deferred("add_child", command)
	root.call_deferred("add_child", mainMenu)
	#root.call_deferred("add_child", upgradeMenu)
	
	
	
	
	
	
	
	


func _on_changeMenu_League():
	root.call_deferred("add_child", leagueMenu)
	pass
	
func _on_changeMenu_Upgrade():
	root.call_deferred("add_child", upgradeMenu)
	pass
	
func _on_changeMenu_Main():
	root.call_deferred("add_child", mainMenu)
	pass
	
func get_player_reference():
	return player






#
#var currentScene = null
#var currentSceneNode = null
#
#const MainMenu = preload("res://Scenes/MainMenu.tscn")
#const Arena = preload("res://Scenes/Arena.tscn")
#
#const obj_player = preload("res://Scenes/Player.tscn")
#
#var scenes = {"MainMenu": MainMenu, "Arena": Arena}
#var player
#
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	change_scene("MainMenu")
#
#
#func change_scene(newScene):
#	if scenes.has(newScene):
#		if(currentScene != null):
#			unload_scene(scenes[currentScene])
#		currentScene = newScene
#		load_scene(scenes[currentScene])
#
#		return true
#	else:
#		return false
#	pass
#
#func unload_scene(scene):
#	currentSceneNode.queue_free()
#
#func load_scene(scene):
#	currentSceneNode = scene.instance()
#	add_child(currentSceneNode)
#
#func _on_MainMenu_start_game():
#	change_scene("Arena")
#	create_player()
#	pass
#
#func create_player():
#	player = obj_player.instance()
#	add_child(player)
#

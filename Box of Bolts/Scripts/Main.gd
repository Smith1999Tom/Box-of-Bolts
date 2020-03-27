extends Node


var currentScene = null
var currentSceneNode = null

const MainMenu = preload("res://Scenes/MainMenu.tscn")
const Arena = preload("res://Scenes/Arena.tscn")

const obj_player = preload("res://Scenes/Player.tscn")

var scenes = {"MainMenu": MainMenu, "Arena": Arena}
var player



# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene("MainMenu")
	

func change_scene(newScene):
	if scenes.has(newScene):
		if(currentScene != null):
			unload_scene(scenes[currentScene])
		currentScene = newScene
		load_scene(scenes[currentScene])
		
		return true
	else:
		return false
	pass

func unload_scene(scene):
	currentSceneNode.queue_free()
	
func load_scene(scene):
	currentSceneNode = scene.instance()
	add_child(currentSceneNode)

func _on_MainMenu_start_game():
	change_scene("Arena")
	create_player()
	pass

func create_player():
	player = obj_player.instance()
	add_child(player)
	

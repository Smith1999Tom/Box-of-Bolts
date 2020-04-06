extends Node

const AI = preload("res://Scenes/AI/AI.tscn")
const Command = preload("res://Scenes/Command/Command.gd")
const MainMenu = preload("res://Scenes/MainMenu/MainMenu.tscn")
const UpgradeMenu = preload("res://Scenes/UpgradeMenu/UpgradeMenu.tscn")
const LeagueMenu = preload("res://Scenes/LeagueMenu/LeagueMenu.tscn")
const Player = preload("res://Scenes/Player/Player.tscn")
const Enemy = preload("res://Scenes/Enemy/Enemy.tscn")

onready var root = get_tree().get_root()

var ai = null
var command = null
var upgradeMenu = null
var leagueMenu = null
var mainMenu = null
var player = null
var enemy = null
var input = null

var actionQueue = []

func _ready():
	ai = AI.instance()
	command = Command.new()
	mainMenu = MainMenu.instance()
	upgradeMenu = UpgradeMenu.instance()
	leagueMenu = LeagueMenu.instance()
	player = Player.instance()
	enemy = Enemy.instance()
	input = InputHandler.new()
	
	player.set_name("player")
	
	mainMenu.init(self)
	leagueMenu.init(self, player)
	upgradeMenu.init(self, player)
	ai.init(self, command, enemy)
	input.init()
	
	
	
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
	
func get_enemy_reference():
	return enemy


func _process(delta):
	
	
	var c : Command = input.handleInput()
	
	if(c):
		c.execute(player)
		
	pass



class InputHandler:
	
	var buttonLeft : Command
	
	func _ready():
		#buttonLeft = Command.StepBackCommand.new()
		pass
		
	func init():
		buttonLeft = StepBackCommand.new()
	
	
	func handleInput():
		if(Input.is_action_just_pressed("ui_left")):
			#print("left")
			return buttonLeft
		pass
		
	
		
	

extends Node2D

const AI = preload("res://Scenes/AI/AI.tscn")
const Command = preload("res://Scenes/Command/Command.gd")
const MainMenu = preload("res://Scenes/MainMenu/MainMenu.tscn")
const UpgradeMenu = preload("res://Scenes/UpgradeMenu/UpgradeMenu.tscn")
const LeagueMenu = preload("res://Scenes/LeagueMenu/LeagueMenu.tscn")
const Player = preload("res://Scenes/Player/Player.tscn")
const Enemy = preload("res://Scenes/Enemy/Enemy.tscn")

onready var root = get_tree().get_root()
const defaultView = Vector2(1280, 720)
var viewScalingFactor = Vector2(1, 1)

var ai = null
var command = null
var upgradeMenu = null
var leagueMenu = null
var mainMenu = null
var player = null
var enemy = null
var input = null
var viewport

var actionQueue = []

func _ready():
	#OS.window_fullscreen = true
	
	#var screensize = get_viewport_rect().size
	viewport = get_viewport()
	#viewport.set_size_override(true, OS.get_window_size())
	viewScalingFactor = Vector2(viewport.size.x/defaultView.x, viewport.size.x/defaultView.x)
	
	$Camera.make_current()
	$Camera.set_position(Vector2(0, 200))
	#$Camera.set_position(Vector2(viewport.size.x/2, viewport.size.y/2 + ((720*viewScalingFactor.y) - viewport.size.y)))
	print(viewport.size.y/2 + ((720*viewScalingFactor.y) - viewport.size.y))
	
	print("DEBUG: Viewport size = " + str(viewport.size.x) + ", " + str(viewport.size.y) + ". Scale factor is " + str(viewScalingFactor))
	
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

func arena_camera():
	$Camera.set_position(Vector2(viewport.size.x/2, viewport.size.y/2 + int(((720*viewScalingFactor.y) - viewport.size.y))))
	print("DEBUG: Moving camera to " + str(Vector2(viewport.size.x/2, viewport.size.y/2 + int(((720*viewScalingFactor.y) - viewport.size.y)))))
	pass

func _process(delta):
	
	
	var c : Command = input.handleInput(get_global_mouse_position())
	
	if(c):
		c.execute(player)
		
	pass



class InputHandler:
	
	var buttonLeft : Command
	var buttonRight : Command
	
	var tapLeft : Command
	var tapRight : Command
	var tapBoth : Command
	var swipeLeft : Command
	var swipeRight : Command
	
	#Swipe detection taken from https://godotengine.org/qa/19386/how-to-detect-swipe-using-3-0
	var swipeStart = null
	var minimumDrag = 100
	
	
	func _ready():
		#buttonLeft = Command.StepBackCommand.new()
		pass
		
	func init():
		
		#buttonLeft = StepBackCommand.new()
		#buttonRight = RPunchCommand.new()
		
		tapLeft = LPunchCommand.new()
		tapRight = RPunchCommand.new()
		tapBoth = BlockCommand.new()
		swipeLeft = StepBackCommand.new()
		swipeRight = StepForwardCommand.new()
	
	
	func handleInput(mousePos):
		var action
#		if(Input.is_action_just_pressed("ui_left")):
#			#print("left")
#			return buttonLeft
#		if(Input.is_action_just_pressed("ui_right")):
#			#print("left")
#			return buttonRight
		
		if(Input.is_action_just_pressed("click")):
			swipeStart = mousePos
		if(Input.is_action_just_released("click")):
			action = calculateSwipe(mousePos)
			if(action):
				return action
			if(mousePos.x < 500):
				return tapLeft
			else:
				return tapRight
				
			
			
	
	#Swipe detection taken from https://godotengine.org/qa/19386/how-to-detect-swipe-using-3-0		
	func calculateSwipe(swipeEnd):
		if(swipeStart == null):
			return
		var swipe = swipeEnd - swipeStart
		print("DEBUG: SS=" + str(swipeStart) + " SE+" + str(swipeEnd))
		print("DEBUG: swipe=" + str(swipe))
		if(abs(swipe.x) > minimumDrag):
			if(swipe.x > 0):
				return swipeRight
			else:
				return swipeLeft
		

		
		
	
		
	

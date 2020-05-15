extends Node2D

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

var bolts = 1000

var mobile = false

onready var camera = $Camera

var actionQueue = []


var LArmSpeedBonus = 0
var LArmDamageBonus = 0
var RArmSpeedBonus = 0
var RArmDamageBonus = 0
var BodyHealthBonus = 0
var BodyEnergyBonus = 0



func _ready():
	camera.move_camera_to_top()
	
	ai = AI.instance()
	command = Command.new()
	mainMenu = MainMenu.instance()
	upgradeMenu = UpgradeMenu.instance()
	leagueMenu = LeagueMenu.instance()
	player = Player.instance()
	enemy = Enemy.instance()
	input = InputHandler.new()
	
	player.set_name("Player")
	
	
	
	mainMenu.init(self)
	leagueMenu.init(self, player)
	upgradeMenu.init(self, player)
	ai.init(self, command, enemy)
	input.init()
	
	root.call_deferred("add_child", ai)
	root.call_deferred("add_child", command)
	root.call_deferred("add_child", mainMenu)
	#root.call_deferred("add_child", upgradeMenu)
	

func _input(event):
	if event is InputEventScreenTouch:
		mobile = true
		if event.pressed == true:
			print("tap tap phone")
		else:
			print("tap tap phone release")
	if event is InputEventMouseButton:
		if(mobile):
			return
		if event.pressed == true:
			print("tap tap mouse")
		else:
			print("tap tap mouse release")
	if event is InputEventKey:
		if ai.keyboardAI == true:
			print("keypress")
			ai.generateCommandFromEvent(event)
		
			
			
	actionQueue.append(input.handleEvent(event))
		


func _on_changeMenu_League():
	root.call_deferred("add_child", leagueMenu)
	pass
	
func _on_changeMenu_Upgrade():
	root.call_deferred("add_child", upgradeMenu)
	pass
	
func _on_changeMenu_Main():
	root.call_deferred("add_child", mainMenu)
	updatePlayerStats()
	pass
	
func get_player_reference():
	return player
	
func get_enemy_reference():
	return enemy
	
func get_view_scaling_factor():
	return camera.viewScalingFactor
	
func move_camera_to_bottom():
	camera.move_camera_to_bottom()
	
func move_camera_to_top():
	camera.move_camera_to_top()
	
func shake_camera():
	camera.shake(0.2, 15, 8)
	pass

func updatePlayerStats():
	player.max_health = 100 + BodyHealthBonus*10
	player.max_energy = 100 + BodyEnergyBonus*10
	player.lPunchSpeed = 1.0 + float(LArmSpeedBonus)/10
	player.lPunchDamage = 5 + LArmDamageBonus
	player.rPunchSpeed = 1.0 + float(RArmSpeedBonus)/10
	player.rPunchDamage = 15 + RArmDamageBonus*3


func _process(delta):
#	var c : Command = input.handleInput(get_global_mouse_position())
#	if(c):
#		c.execute(player)
	for action in actionQueue:
		if(action):
			action.execute(player)
	actionQueue.clear()
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
	
	var tapQueue = []
	
	
	func _ready():
		pass
		
	func init():
		tapLeft = LPunchCommand.new()
		tapRight = RPunchCommand.new()
		tapBoth = BlockCommand.new()
		swipeLeft = StepBackCommand.new()
		swipeRight = StepForwardCommand.new()
	
	func handleInput(mousePos):
		var action
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
				
	func handleEvent(event):
		if event is InputEventScreenTouch:
			return handleTapEvent(event)
		if event is InputEventMouseButton:
			return handleTapEvent(event)
		
				
	func handleTapEvent(event):
		if event.pressed:
				tapQueue.append(event)
		else:
			if tapQueue.size() == 1:
				var tap = tapQueue.back()
				tapQueue.clear()
				swipeStart = tap.position
				var swipe = calculateSwipe(event.position)
				if(swipe) :
					return swipe
				if event is InputEventScreenTouch:
					if(tap.position.x > 640):
						return tapRight
					else:
						return tapLeft
				elif event is InputEventMouseButton:
					if(event.button_index == 1):
						return tapLeft
					elif(event.button_index == 2):
						return tapRight
			
			tapBoth.block = false
			tapQueue.clear()
			return tapBoth
		
		if tapQueue.size() > 1:
			print("Two taps")
			for item in tapQueue:
				if item is InputEventScreenTouch:
					print("Tap " + str(item.index) + " at " + str(item.position))
				tapBoth.block = true
				return tapBoth
	
				
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

extends Node

var main = null
var command = null
var enemy = null
export var randomAI = false
export var keyboardAI = false
export var smartAI = true

var rng = RandomNumberGenerator.new()

var tapLeft : Command
var tapRight : Command
var tapBoth : Command
var swipeLeft : Command
var swipeRight : Command
var commandList = []

var waitingState : WaitingState
var respondingState : RespondingState

var currentState : AIState

var numberOfCommands = 5

var baseResponseTime = 0.2
var difficulty = 60

var onCooldown = false
var cooldownTimer = 1.0

func _ready():
	pass
	
func init(mainRef, commandRef, enemyRef):
	main = mainRef
	command = commandRef
	enemy = enemyRef
	
	rng.randomize()
	
	tapLeft = LPunchCommand.new()
	tapRight = RPunchCommand.new()
	tapBoth = BlockCommand.new()
	swipeLeft = StepBackCommand.new()
	swipeRight = StepForwardCommand.new()
	
	waitingState = WaitingState.new()
	respondingState = RespondingState.new()
	waitingState.init(respondingState, waitingState)
	respondingState.init(respondingState, waitingState)
	currentState = waitingState
	
	
	
	commandList.append(tapLeft)
	commandList.append(tapRight)
	commandList.append(tapBoth)
	commandList.append(swipeLeft)
	commandList.append(swipeRight)

func executeCommand(command : Command):
	command.execute(enemy)

func generateCommand():
	if(onCooldown):
		return
	
	if(keyboardAI):
		return
		
	onCooldown = true
	if(randomAI):
		var command = getRandomCommand()
		command.execute(enemy)
	if(smartAI):
		#Get the new action - either a new state(if transitioning) or a command to execute
		var action = currentState.generateCommand(enemy, main.player)
		if action is Command:	#Execute command
			executeCommand(action)
		if action is AIState:
			currentState.exit()
			yield(get_tree().create_timer(reactionTime()), "timeout")
			currentState = action
			currentState.enter()
			generateCommand()
		if action is String:	#Transition to new state. State must return new state as a string to avoid cyclid dependencies
								#until issue is fixed https://github.com/godotengine/godot/issues/27136
			currentState.exit()
			yield(get_tree().create_timer(reactionTime()), "timeout")
			match action:
				"respondingState":
					currentState = respondingState
				"waitingState":
					currentState = waitingState
			currentState.enter()
			generateCommand()
		
		
	onCooldown = false
	
func generateCommandFromEvent(event):
	if onCooldown == true:
		return
	
	if event is InputEventKey:
		var keyPress = OS.get_scancode_string(event.scancode)
		print("Generating command from " + keyPress)
		match keyPress:
			"Q":
				tapLeft.execute(enemy)
			"W":
				tapBoth.block = !tapBoth.block
				tapBoth.execute(enemy)
			"E":
				tapRight.execute(enemy)
			"A":
				swipeLeft.execute(enemy)
			"S":
				swipeRight.execute(enemy)
		
		onCooldown = true
		var timer = Timer.new()
		timer.one_shot = true
		timer.connect("timeout", self, "endCooldown")
		add_child(timer)
		timer.start(cooldownTimer)
		
	pass
	
func getRandomCommand():
	var randomNumber = rng.randi_range(0, numberOfCommands-1)
	return commandList[randomNumber]
	
	pass
	
func reactionTime():
	var randomNumber = rng.randf_range(0.0, (100.0-difficulty)/100.0)
	print("DEBUG: AI responded in " + str(baseResponseTime+randomNumber))
	return baseResponseTime + randomNumber
	
func endCooldown():
	onCooldown = false
	
	

extends Node

var main = null
var command = null
var enemy = null
export var randomAI = true
export var keyboardAI = false

var rng = RandomNumberGenerator.new()

var tapLeft : Command
var tapRight : Command
var tapBoth : Command
var swipeLeft : Command
var swipeRight : Command
var commandList = []

var numberOfCommands = 5

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
	
	commandList.append(tapLeft)
	commandList.append(tapRight)
	commandList.append(tapBoth)
	commandList.append(swipeLeft)
	commandList.append(swipeRight)


func generateCommand():
	if(keyboardAI):
		return
	if(randomAI):
		var command = getRandomCommand()
		command.execute(enemy)
	pass
	
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
	
func endCooldown():
	onCooldown = false
	
	

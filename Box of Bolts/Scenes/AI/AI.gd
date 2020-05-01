extends Node

var main = null
var command = null
var enemy = null
export var randomAI = true

var rng = RandomNumberGenerator.new()

var tapLeft : Command
var tapRight : Command
var tapBoth : Command
var swipeLeft : Command
var swipeRight : Command
var commandList = []

var numberOfCommands = 5

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
	if(randomAI):
		var command = getRandomCommand()
		command.execute(enemy)
	pass
	
func getRandomCommand():
	var randomNumber = rng.randi_range(0, numberOfCommands-1)
	return commandList[randomNumber]
	
	pass

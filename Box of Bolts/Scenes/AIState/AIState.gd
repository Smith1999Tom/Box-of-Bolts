extends Node

class_name AIState

var tapLeft : Command
var tapRight : Command
var tapBoth : Command
var swipeLeft : Command
var swipeRight : Command
var idle : Command


func _ready():
	print("Initializing State")
	tapLeft = LPunchCommand.new()
	tapRight = RPunchCommand.new()
	tapBoth = BlockCommand.new()
	swipeLeft = StepBackCommand.new()
	swipeRight = StepForwardCommand.new()
	idle = IdleCommand.new()


func generateCommand(mech : Mech, opponent : Mech):
	#Virtual function to be implemented by specific state
	return idle


func enter():
	pass
	
func exit():
	pass

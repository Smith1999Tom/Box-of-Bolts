extends Node

class_name AIState

var tapLeft : Command
var tapRight : Command
var tapBoth : Command
var swipeLeft : Command
var swipeRight : Command
var idle : Command

var respondingState
var waitingState
var attackingState

func _ready():
	pass
	
func init(aRespondingState, aWaitingState, aAttackingState):
	respondingState = aRespondingState
	waitingState = aWaitingState
	attackingState = aAttackingState
	
	tapLeft = LPunchCommand.new()
	tapRight = RPunchCommand.new()
	tapBoth = BlockCommand.new()
	swipeLeft = StepBackCommand.new()
	swipeRight = StepForwardCommand.new()
	idle = IdleCommand.new()
	pass


func generateCommand(mech : Mech, opponent : Mech):
	#Virtual function to be implemented by specific state
	return idle


func enter():
	_ready()
	pass
	
func exit():

	pass

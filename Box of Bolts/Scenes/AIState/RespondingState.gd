extends AIState

class_name RespondingState

var reactionTimeMin = 0.2

func _ready():
	._ready()
	pass
	
func generateCommand(mech, opponent):
	if(opponent.state == "LeftPunch" or opponent.state == "RightPunch"):
		#print("AIWAITINGSTATE: Opponent is attacking")
		tapBoth.block = true
		return tapBoth
	else:
		return "waitingState"
	pass
	
func enter():
	pass
	
func exit():
	pass

extends AIState

class_name RespondingState


func _ready():
	._ready()
	pass
	
func generateCommand(mech, opponent):
	if(mech.state == "Hit"):
		return "waitingState"
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

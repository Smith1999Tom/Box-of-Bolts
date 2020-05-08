extends AIState

class_name RespondingState


func _ready():
	._ready()
	pass
	
func generateCommand(mech, opponent):
	if(mech.state == "Hit"):
		return waitingState
	
	var distance = mech.getDistanceBetweenMechs()
	if distance <= mech.stepForwardDistance * 4:	#Mech is close, need to counter
		return counter(mech, opponent)
		pass
	
	pass
	
func counter(mech, opponent):
	if opponent.state == "LeftPunch":
		tapBoth.block = true
		return tapBoth
	elif opponent.state == "RightPunch":
		return tapLeft
	else:
		return waitingState
	

func enter():
	print("DEBUG: AI responding")
	pass
	
func exit():
	pass

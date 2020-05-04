extends AIState

class_name WaitingState

func _ready():
	print("Initializing WaitingState")
	._ready()


func generateCommand(mech, opponent):
	
	#Check if opponent is attacking
	if(opponent.state == "RightPunch"):
		#print("AIWAITINGSTATE: Opponent is attacking")
		#tapBoth.block = true
		return "respondingState"
	else:
		return idle
		
func enter():
	pass
	
func exit():
	pass

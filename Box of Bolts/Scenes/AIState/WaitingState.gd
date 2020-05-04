extends AIState

class_name WaitingState

func _ready():
	print("Initializing WaitingState")
	._ready()

func generateCommand(mech, opponent) -> Command:
	
	#Check if opponent is attacking
	if(opponent.state == "LeftPunch" or opponent.state == "RightPunch"):
		#print("AIWAITINGSTATE: Opponent is attacking")
		tapBoth.block = true
		return tapBoth
	else:
		return idle

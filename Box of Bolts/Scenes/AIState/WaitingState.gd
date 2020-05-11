extends AIState

class_name WaitingState

var waitingTime = 0.0

func _ready():
	._ready()
	

func _process(delta):
	waitingTime += delta


func generateCommand(mech, opponent):
	
	#Check if opponent is attacking
	if(opponent.state == "RightPunch" or opponent.state == "LeftPunch"):
		#print("AIWAITINGSTATE: Opponent is attacking")
		#tapBoth.block = true
		return respondingState
	elif(waitingTime >= 3):
		return attackingState
	else:
		return idle
		
func enter():
	print("DEBUG: AI waiting")
	waitingTime = 0.0
	set_process(true)
	pass
	
func exit():
	pass

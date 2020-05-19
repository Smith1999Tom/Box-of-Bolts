extends AIState

class_name WaitingState

var waitingTime = 0.0

func _ready():
	._ready()
	

func _process(delta):
	waitingTime += delta


func generateCommand(mech, opponent):
	if(mech.state == "Hit" or mech.state == "Countdown"):
		return idle
	
	var distance = mech.getDistanceBetweenMechs()
	
	#Check if opponent is attacking
	if(opponent.state == "RightPunch" or opponent.state == "LeftPunch"):
		#print("AIWAITINGSTATE: Opponent is attacking")
		#tapBoth.block = true
		return respondingState
	elif(mech.energy < mech.max_energy/2):
		if(distance <= 400):
			return swipeLeft
		else:
			return idle
	elif(distance <= 400):
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

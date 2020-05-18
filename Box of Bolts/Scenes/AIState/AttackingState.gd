extends AIState

class_name AttackingState

var punches = 0

func _ready():
	punches = 0
	._ready()
	pass

func generateCommand(mech, opponent):
	var distance = mech.getDistanceBetweenMechs()
	if(distance > 400):
		print("DEBUG: AI advancing to attack")
		return swipeRight
	if(mech.energy < mech.lPunchEnergy):
		return waitingState
	elif(punches < 3):
		punches += 1
		return tapLeft
	else:
		if(mech.energy < mech.rPunchEnergy):
			return waitingState
		punches +=1
		return tapRight
	pass

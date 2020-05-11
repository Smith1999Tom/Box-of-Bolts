extends AIState

class_name AttackingState

var punches = 0

func _ready():
	punches = 0
	._ready()
	pass

func generateCommand(mech, opponent):
	if(mech.energy < mech.lPunchEnergy):
		return waitingState
	return tapLeft
	pass

extends Command

class_name StepForwardCommand
	
func execute(mech):
	if(mech.get_parent()):
		mech.stepForward()
		print("DEBUG: " + mech.name	+ ":STEPFORWARD")
	

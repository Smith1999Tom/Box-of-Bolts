extends Command

class_name StepBackCommand
	
func execute(mech):
	if(mech.get_parent()):
		mech.stepBackward()
		print("DEBUG: " + mech.name	+ ":STEPBACK")
	

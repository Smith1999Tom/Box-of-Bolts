extends Command

class_name StepBackCommand
	
func execute(mech):
	if(mech.get_parent()):
		#mech.step_back()
		print("DEBUG: " + mech.name	+ ":STEPBACK")
	

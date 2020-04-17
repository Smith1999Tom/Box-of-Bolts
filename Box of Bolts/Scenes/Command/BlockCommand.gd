extends Command

class_name BlockCommand
	
func execute(mech):
	if(mech.get_parent()):
		#mech.step_back()
		print("DEBUG: " + mech.name	+ ":BLOCK")
	

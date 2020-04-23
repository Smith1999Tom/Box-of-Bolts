extends Command

class_name LPunchCommand
	
func execute(mech):
	if(mech.get_parent()):
		mech.lPunch()
		print("DEBUG: " + mech.name	+ ":LPUNCH")
	

extends Command

class_name RPunchCommand
	
func execute(mech):
	if(mech.get_parent()):
		mech.rPunch()
		print("DEBUG: " + mech.name	+ ":RPUNCH")
	

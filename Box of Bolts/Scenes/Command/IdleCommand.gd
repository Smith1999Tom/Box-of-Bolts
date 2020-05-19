extends Command

class_name IdleCommand
	
func execute(mech):
	if(mech.get_parent()):
		mech.idle()
	

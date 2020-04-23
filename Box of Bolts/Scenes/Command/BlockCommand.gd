extends Command

class_name BlockCommand
	
var block = false
	
func execute(mech):
	if(mech.get_parent()):
		if(block):
			mech.block()
		else:
			mech.end_block()
	

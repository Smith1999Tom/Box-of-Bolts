extends Camera2D

const defaultView = Vector2(1280, 720)
var viewScalingFactor = Vector2(1, 1)
var viewport


func _ready():
	viewport = get_viewport()
	viewScalingFactor = Vector2(viewport.size.x/defaultView.x, viewport.size.x/defaultView.x)
	#print("DEBUG: Viewport size = " + str(viewport.size.x) + ", " + str(viewport.size.y) + ". Scale factor is " + str(viewScalingFactor))
	self.make_current()

func move_camera_to_top():
	self.set_position(Vector2(viewport.size.x/2, viewport.size.y/2))
	#print("DEBUG: Moving camera to 0, 0")

#Moves the camera to the bottom of the screen, so that the top is cut off instead of the bottom
#This is done so that in the fight, the sky is cut off instead of the bottom of the mechs
func move_camera_to_bottom():
	self.set_position(Vector2(viewport.size.x/2, viewport.size.y/2 + int(((720*viewScalingFactor.y) - viewport.size.y))))
	print("DEBUG: Moving camera to " + str(Vector2(viewport.size.x/2, viewport.size.y/2 + int(((720*viewScalingFactor.y) - viewport.size.y)))))
	pass

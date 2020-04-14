extends Camera2D

const defaultView = Vector2(1280, 720)
var viewScalingFactor = Vector2(1, 1)
var viewport
var velocity = 0.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	viewport = get_viewport()
	
	viewScalingFactor = Vector2(viewport.size.x/defaultView.x, viewport.size.x/defaultView.x)
	print("DEBUG: Viewport size = " + str(viewport.size.x) + ", " + str(viewport.size.y) + ". Scale factor is " + str(viewScalingFactor))
	self.make_current()
	pass # Replace with function body.
	
func _process(delta):
	self.position.x += velocity * delta
	pass
	
	

func move_camera_to_top():
	self.set_position(Vector2(viewport.size.x/2, viewport.size.y/2))
	print("DEBUG: Moving camera to 0, 0")


#Moves the camera to the bottom of the screen, so that the top is cut off instead of the bottom
#This is done so that in the fight, the sky is cut off instead of the bottom of the mechs
func move_camera_to_bottom():
	self.set_position(Vector2(viewport.size.x/2, viewport.size.y/2 + int(((720*viewScalingFactor.y) - viewport.size.y))))
	print("DEBUG: Moving camera to " + str(Vector2(viewport.size.x/2, viewport.size.y/2 + int(((720*viewScalingFactor.y) - viewport.size.y)))))
	pass
	
func slide_camera_left():
	velocity = 1280 * 0.25 * -1
	_start_timer()
	pass
	
func slide_camera_right():
	velocity = 1280 * 0.25
	_start_timer()
	pass
	
func _start_timer():
	var timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 1.0
	timer.connect("timeout", self, "_timeout")
	pass
	
	
func _timeout():
	velocity = 0

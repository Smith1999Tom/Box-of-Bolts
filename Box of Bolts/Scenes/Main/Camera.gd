extends Camera2D

const defaultView = Vector2(1280, 720)
var viewScalingFactor = Vector2(1, 1)
var viewport

var _duration = 0.0
var _period_in_ms = 0.0
var _amplitude = 0.0
var _timer = 0.0
var _last_shook_timer = 0
var _previous_x = 0.0
var _previous_y = 0.0
var _last_offset = Vector2(0, 0)

func _ready():
	viewport = get_viewport()
	viewScalingFactor = Vector2(viewport.size.x/defaultView.x, viewport.size.x/defaultView.x)
	#print("DEBUG: Viewport size = " + str(viewport.size.x) + ", " + str(viewport.size.y) + ". Scale factor is " + str(viewScalingFactor))
	self.make_current()
	set_process(true)	#Used for camera shake

func move_camera_to_top():
	self.set_position(Vector2(viewport.size.x/2, viewport.size.y/2))
	#print("DEBUG: Moving camera to 0, 0")

#Moves the camera to the bottom of the screen, so that the top is cut off instead of the bottom
#This is done so that in the fight, the sky is cut off instead of the bottom of the mechs
func move_camera_to_bottom():
	self.set_position(Vector2(viewport.size.x/2, viewport.size.y/2 + int(((720*viewScalingFactor.y) - viewport.size.y))))
	print("DEBUG: Moving camera to " + str(Vector2(viewport.size.x/2, viewport.size.y/2 + int(((720*viewScalingFactor.y) - viewport.size.y)))))
	pass


   
#Camera shake functions taken from https://godotengine.org/qa/438/camera2d-screen-shake-extension?show=438#q438

# Shake with decreasing intensity while there's time remaining.
func _process(delta):
	# Only shake when there's shake time remaining.
	if _timer == 0:
		return
	# Only shake on certain frames.
	_last_shook_timer = _last_shook_timer + delta
	# Be mathematically correct in the face of lag; usually only happens once.
	while _last_shook_timer >= _period_in_ms:
		_last_shook_timer = _last_shook_timer - _period_in_ms
		# Lerp between [amplitude] and 0.0 intensity based on remaining shake time.
		var intensity = _amplitude * (1 - ((_duration - _timer) / _duration))
		# Noise calculation logic from http://jonny.morrill.me/blog/view/14
		var new_x = rand_range(-1.0, 1.0)
		var x_component = intensity * (_previous_x + (delta * (new_x - _previous_x)))
		var new_y = rand_range(-1.0, 1.0)
		var y_component = intensity * (_previous_y + (delta * (new_y - _previous_y)))
		_previous_x = new_x
		_previous_y = new_y
		# Track how much we've moved the offset, as opposed to other effects.
		var new_offset = Vector2(x_component, y_component)
		set_offset(get_offset() - _last_offset + new_offset)
		_last_offset = new_offset
	# Reset the offset when we're done shaking.
	_timer = _timer - delta
	if _timer <= 0:
		_timer = 0
		set_offset(get_offset() - _last_offset)

# Kick off a new screenshake effect.
func shake(duration, frequency, amplitude):
	# Initialize variables.
	_duration = duration
	_timer = duration
	_period_in_ms = 1.0 / frequency
	_amplitude = amplitude
	_previous_x = rand_range(-1.0, 1.0)
	_previous_y = rand_range(-1.0, 1.0)
	# Reset previous offset, if any.
	set_offset(get_offset() - _last_offset)
	_last_offset = Vector2(0, 0)

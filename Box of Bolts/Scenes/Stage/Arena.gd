extends Node2D
onready var root = get_tree().get_root()

var main = null
var player = null
var enemy = null

var oldpos = 0
var velocity = 0.0
var leftBoundary = 0
var rightBoundary = 0

func _ready():
	self.scale = main.get_view_scaling_factor()
	main.move_camera_to_bottom()
	
	leftBoundary = 0
	rightBoundary = 1280
	
	pass
	
func _process(delta):
	self.position.x += velocity * delta * main.get_view_scaling_factor().x
	pass
	
	
	
func init(mainRef):
	main = mainRef
	
	player = main.get_player_reference()
	#player.scale = main.viewScalingFactor
	enemy = main.get_enemy_reference()
	
	call_deferred("add_child", player)
	call_deferred("add_child", enemy)
	
func slide_stage_left():
	velocity = 1280 * 0.25 * player.stepBackwardSpeed
	print("DEBUG: STAGE POS START - " + str(self.position.x))
	_start_timer()
	pass
	
func slide_stage_right():
	velocity = 1280 * 0.25 * -1
	_start_timer()
	pass

func _start_timer():
	var timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.wait_time = 1.0
	timer.start()
	timer.connect("timeout", self, "_timeout")
	oldpos = self.position.x
	pass
	
	
func _timeout():
	velocity = 0
	var difference = self.position.x - oldpos
	leftBoundary -= difference/main.get_view_scaling_factor().x
	rightBoundary -= difference/main.get_view_scaling_factor().x
	print("DEBUG: STAGE POS END - " + str(self.position.x))

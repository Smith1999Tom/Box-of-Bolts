extends Node2D
onready var root = get_tree().get_root()

var main = null
var player = null
var enemy = null

var scaleFactor = 1.0

#Used to slide the arena left and right to simulate camera movement
var oldpos = 0
var velocity = 0.0
#Left and right boundaries are arbitrary since they are affected by view scaling factor, whereas stage pos is not
var leftBoundary = 0
var rightBoundary = 0

func _ready():
	scaleFactor = main.get_view_scaling_factor()
	self.scale = scaleFactor
	main.move_camera_to_bottom()
	
	leftBoundary = 0
	rightBoundary = 1280
	
func _process(delta):
	self.position.x += velocity * delta * main.get_view_scaling_factor().x
	#$Farm_Layer_1.position.x += velocity * delta * main.get_view_scaling_factor().x
	$Farm_Layer_2.position.x -= velocity * delta * 0.6
	$Farm_Layer_3.position.x -= velocity * delta * 0.8
	$Farm_Layer_4.position.x += velocity * delta * 0
	pass
	
#Set initial values
func init(mainRef):
	main = mainRef
	player = main.get_player_reference()
	enemy = main.get_enemy_reference()
	
	call_deferred("add_child", player)
	call_deferred("add_child", enemy)
	
	player.init(scaleFactor)
	#enemy.init(scaleFactor)
	
func slide_stage_left():
	velocity = 1280 * 0.25 * player.stepBackwardSpeed	#1/4 of the screen at the same speed as the player.
	#TODO change distance to be equal to player step
	#print("DEBUG: STAGE POS START - " + str(self.position.x))
	_start_timer()
	
func slide_stage_right():
	velocity = 1280 * 0.25 * -1
	_start_timer()

#Starts a timer for moving the stage left/right
func _start_timer():
	var timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.wait_time = 1.0
	timer.start()
	timer.connect("timeout", self, "_timeout")
	oldpos = self.position.x
	
func _timeout():
	velocity = 0
	var difference = self.position.x - oldpos
	leftBoundary -= difference/main.get_view_scaling_factor().x
	rightBoundary -= difference/main.get_view_scaling_factor().x
	#print("DEBUG: STAGE POS END - " + str(self.position.x))

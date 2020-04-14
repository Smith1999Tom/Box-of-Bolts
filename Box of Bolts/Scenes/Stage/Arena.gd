extends Node2D
onready var root = get_tree().get_root()

var main = null
var player = null
var enemy = null
var velocity = 0.0

func _ready():
	self.scale = main.get_view_scaling_factor()
	main.move_camera_to_bottom()
	
	pass
	
func _process(delta):
	self.position.x += velocity * delta
	pass
	
	
	
func init(mainRef):
	main = mainRef
	
	player = main.get_player_reference()
	#player.scale = main.viewScalingFactor
	enemy = main.get_enemy_reference()
	
	call_deferred("add_child", player)
	call_deferred("add_child", enemy)
	
func slide_stage_left():
	velocity = 1280 * 0.25
	_start_timer()
	pass
	
func slide_stage_right():
	velocity = 1280 * 0.25 * -1
	_start_timer()
	pass

func _start_timer():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.start()
	timer.connect("timeout", self, "_timeout")
	pass
	
	
func _timeout():
	velocity = 0

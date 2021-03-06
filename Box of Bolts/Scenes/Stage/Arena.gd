extends Node2D
onready var root = get_tree().get_root()

var main = null
var player = null
var enemy = null
onready var gui = $ArenaGuiLayer/ArenaGUI


var scaleFactor = 1.0

#Used to slide the arena left and right to simulate camera movement
var oldpos = 0
var newpos = 0
var velocity = 0.0
var timeLeft = 0.0
#Left and right boundaries are arbitrary since they are affected by view scaling factor, whereas stage pos is not
var leftBoundary = 0
var rightBoundary = 0

func _ready():
	
	$CountdownLayer/CountdownSprite.play()
	add_child(player)
	add_child(enemy)
	scaleFactor = main.get_view_scaling_factor()
	self.scale = scaleFactor
	$CountdownLayer.scale = scaleFactor
	main.move_camera_to_bottom()
	gui.init()
	leftBoundary = 0
	rightBoundary = 1280
	
	$EndSlateLayer/Control.hide()
	
	
	
	player.init(scaleFactor, enemy, main)
	enemy.init(scaleFactor, player, main)
	
func _process(delta):
	if(timeLeft <= 0):
		timeLeft = 0
		stop_stage()
	else:
		timeLeft -= delta
	
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
	
	

	
func slide_stage_left():
	#velocity = (1280/player.stepForwardDistance) * 10 * (1/player.stepBackwardSpeed)	#1/4 of the screen at the same speed as the player.
	velocity = player.stepForwardDistance / (player.stepBackwardSpeed*2)
	timeLeft = player.stepBackwardSpeed*2
	newpos = oldpos + (player.stepForwardDistance * scaleFactor.x)
	update_boundaries()
	
func slide_stage_right():
	velocity = enemy.stepForwardDistance / (enemy.stepBackwardSpeed*2) * -1
	timeLeft = enemy.stepBackwardSpeed*2
	newpos = oldpos - (player.stepForwardDistance * scaleFactor.x)
	update_boundaries()
	
	#Movement of player
	#self.position.x -= ((stepForwardDistance * delta * stepBackwardSpeed * direction) / scaleFactor)

func update_boundaries():
	var difference = newpos - oldpos
	newpos = oldpos
	leftBoundary -= difference/main.get_view_scaling_factor().x
	rightBoundary -= difference/main.get_view_scaling_factor().x
	leftBoundary = round(leftBoundary)
	$LBound.rect_position.x = leftBoundary-10
	$RBound.rect_position.x = rightBoundary
	rightBoundary = round(rightBoundary)

func stop_stage():
	if(velocity != 0):
		velocity = 0
		
	pass


func _on_CountdownSprite_animation_finished():
	
	call_deferred("remove_child", $CountdownLayer)
	pass # Replace with function body.


func _on_CountdownSprite_frame_changed():
	if($CountdownLayer/CountdownSprite.frame == 3):
		if(player.state == "Countdown"):
			player.idle()
		if(enemy.state == "Countdown"):
			enemy.idle()
	pass # Replace with function body.
	
	
func onGameEnd(boltAmount):
	$EndSlateLayer/Control.show()
	$EndSlateLayer/Control/Bolts.text = str(boltAmount)
	main.bolts += boltAmount
	$ArenaGuiLayer/ArenaGUI.hide()
	player.state = "Countdown"
	enemy.state = "Countdown"
	pass
	
func onWin():
	print("win")
	onGameEnd(130)
	$EndSlateLayer/Control/LoseCard.hide()
	yield(get_tree().create_timer(3.0), "timeout")
	returnToMenu()
	pass
	
func onLose():
	print("lose")
	onGameEnd(30)
	$EndSlateLayer/Control/WinCard.hide()
	yield(get_tree().create_timer(3.0), "timeout")
	returnToMenu()
	pass
	
func returnToMenu():
	main._on_changeMenu_Main()
	root.call_deferred("remove_child", self)
	pass

extends ColorRect

onready var viewport = get_viewport()
var scaleFactor = Vector2(1.0, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	
	pass # Replace with function body.

func init(scale):
	scaleFactor = scale
	self.move_ui()

	

func move_ui():
	$StartBtn.rect_size = Vector2(viewport.size.x*0.4, viewport.size.y*0.2)/scaleFactor.x	#Set size of start button
	#StartBtn.rect_position = Vector2(((viewport.size.x/scaleFactor.x)-$StartBtn.rect_size.x)/2, (viewport.size.y/scaleFactor.x)*0.7)
	$StartBtn.rect_position.x = ((viewport.size.x/scaleFactor.x)-$StartBtn.rect_size.x)/2
	$StartBtn.rect_position.y = (viewport.size.y/scaleFactor.x)*0.7
	#print("button y = " + str(viewport.size.y) + "/" + str(scaleFactor.x) + "*0.7")
	$BackBtn.rect_size = Vector2(viewport.size.x*0.2, viewport.size.y*0.2)/scaleFactor.x
	$BackBtn.rect_position = Vector2(viewport.size.y*0.1, viewport.size.y*0.1)/scaleFactor.x
	$Label.rect_size = Vector2(viewport.size.x*0.2, viewport.size.y*0.2)/scaleFactor.x
	$Label.rect_position = Vector2(((viewport.size.x/scaleFactor.x)-$Label.rect_size.x/2)/2, (viewport.size.y/scaleFactor.x)/2)

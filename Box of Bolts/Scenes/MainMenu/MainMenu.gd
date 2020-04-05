extends CanvasLayer

signal start_game


var player

func hide():
	$Label.hide()
	$Button.hide()
	
func show():
	$Label.show()
	$Button.show()

func _ready():
	self.connect("start_game", self.get_parent(), "_on_MainMenu_start_game")
	

func _on_Button_start_fight():
	emit_signal("start_game")
	

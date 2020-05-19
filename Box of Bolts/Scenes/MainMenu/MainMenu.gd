extends CanvasLayer

signal changeMenu_League
signal changeMenu_Upgrade

var main = null
onready var root = get_tree().get_root()


func _ready():
	connect("changeMenu_League", main, "_on_changeMenu_League")
	connect("changeMenu_Upgrade", main, "_on_changeMenu_Upgrade")
	pass

func init(MainReference):
	main = MainReference
	pass

func _on_LeagueBtn_pressed():
	emit_signal("changeMenu_League")
	root.call_deferred("remove_child", self)


func _on_UpgradeBtn_pressed():
	emit_signal("changeMenu_Upgrade")
	root.call_deferred("remove_child", self)


func _on_HelpBack_pressed():
	$HelpScreen.hide()
	$HelpButton.show()
	pass # Replace with function body.


func _on_HelpButton_pressed():
	$HelpScreen.show()
	$HelpButton.hide()
	pass # Replace with function body.

extends CanvasLayer

signal changeMenu_League
signal changeMenu_Upgrade

var main = null


func _ready():
	connect("changeMenu_League", main, "_on_changeMenu_League")
	connect("changeMenu_Upgrade", main, "_on_changeMenu_Upgrade")
	pass

func init(MainReference):
	main = MainReference
	pass

func _on_LeagueBtn_pressed():
	emit_signal("changeMenu_League")


func _on_UpgradeBtn_pressed():
	emit_signal("changeMenu_Upgrade")

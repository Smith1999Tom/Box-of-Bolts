extends Node

signal changeMenu_Main

var main = null
var player = null

var bolts = -1

onready var root = get_tree().get_root()
onready var display = $CanvasLayer

var LArmSpeedCost
var LArmSpeedBonus
var LArmDamageCost
var LArmDamageBonus
var RArmSpeedCost
var RArmSpeedBonus
var RArmDamageCost
var RArmDamageBonus
var BodyHealthCost
var BodyHealthBonus
var BodyEnergyCost
var BodyEnergyBonus


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	connect("changeMenu_Main", main, "_on_changeMenu_Main")
	bolts = main.bolts
	display.get_node("BoltCount").text = str(bolts)
	
	
	LArmSpeedBonus = main.LArmSpeedBonus
	LArmDamageBonus = main.LArmDamageBonus
	RArmSpeedBonus = main.RArmSpeedBonus
	RArmDamageBonus = main.RArmDamageBonus
	BodyHealthBonus = main.BodyHealthBonus
	BodyEnergyBonus = main.BodyEnergyBonus
	
	LArmSpeedCost = LArmSpeedBonus * 10 + 100
	LArmDamageCost = LArmDamageBonus * 10 + 100
	RArmSpeedCost = RArmSpeedBonus * 10 + 100
	RArmDamageCost = RArmDamageBonus * 10 + 100
	BodyHealthCost = BodyHealthBonus * 10 + 100
	BodyEnergyCost = BodyEnergyBonus * 10 + 100
	
	refreshValues()

func init(MainRef, PlayerRef):
	main = MainRef
	player = PlayerRef

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackBtn_pressed():
	
	main.LArmSpeedBonus = LArmSpeedBonus
	main.LArmDamageBonus = LArmDamageBonus
	main.RArmSpeedBonus = RArmSpeedBonus
	main.RArmDamageBonus = RArmDamageBonus
	main.BodyHealthBonus = BodyHealthBonus
	main.BodyEnergyBonus = BodyEnergyBonus
	
	
	emit_signal("changeMenu_Main")
	root.call_deferred("remove_child", self)
	print("Back")
	pass # Replace with function body.



func _on_CountBtn_pressed():
	var result = int($CountLbl.text)
	result += 1
	$CountLbl.text = str(result)
	player.set_health(100 + (result*10))
	#add_child(player)


func _on_LArmBtn_pressed():
	display.get_node("LArm").show()
	display.get_node("RArm").hide()
	display.get_node("Body").hide()
	pass # Replace with function body.


func _on_RArmBtn_pressed():
	display.get_node("LArm").hide()
	display.get_node("RArm").show()
	display.get_node("Body").hide()


func _on_BodyBtn_pressed():
	display.get_node("LArm").hide()
	display.get_node("RArm").hide()
	display.get_node("Body").show()




func _on_LArmSpeedBtn_pressed():
	if(LArmSpeedCost <= bolts):
		LArmSpeedBonus += 1
		bolts -= LArmSpeedCost
		LArmSpeedCost += 10
		refreshValues()



func _on_LArmDamageBtn_pressed():
	if(LArmDamageCost <= bolts):
		LArmDamageBonus += 1
		bolts -= LArmDamageCost
		LArmDamageCost += 10
		refreshValues()


func _on_RArmSpeedBtn_pressed():
	if(RArmSpeedCost <= bolts):
		RArmSpeedBonus += 1
		bolts -= RArmSpeedCost
		RArmSpeedCost += 10
		refreshValues()


func _on_RArmDamageBtn_pressed():
	if(RArmDamageCost <= bolts):
		RArmDamageBonus += 1
		bolts -= RArmDamageCost
		RArmDamageCost += 10
		refreshValues()


func _on_BodyHealthBtn_pressed():
	if(BodyHealthCost <= bolts):
		BodyHealthBonus += 1
		bolts -= BodyHealthCost
		BodyHealthCost += 10
		refreshValues()


func _on_BodyEnergyBtn_pressed():
	if(BodyEnergyCost <= bolts):
		BodyEnergyBonus += 1
		bolts -= BodyEnergyCost
		BodyEnergyCost += 10
		refreshValues()
		
		
func refreshValues():
	$CanvasLayer/LArm/LARM/HBoxContainer/MarginContainer2/MarginContainer5/BoltCostLArmSpeed.text = str(LArmSpeedCost)
	$CanvasLayer/LArm/LARM/HBoxContainer/MarginContainer2/MarginContainer5/LArmSpeedBonus.text = "+" + str(LArmSpeedBonus)
	$CanvasLayer/LArm/LARM/HBoxContainer/MarginContainer3/MarginContainer6/BoltCostLArmDamage.text = str(LArmDamageCost)
	$CanvasLayer/LArm/LARM/HBoxContainer/MarginContainer3/MarginContainer6/LArmDamageBonus.text = "+" + str(LArmDamageBonus)
	
	$CanvasLayer/RArm/RARM/HBoxContainer/MarginContainer2/MarginContainer3/BoltCostRArmSpeed.text = str(RArmSpeedCost)
	$CanvasLayer/RArm/RARM/HBoxContainer/MarginContainer2/MarginContainer3/RArmSpeedBonus.text = "+" + str(RArmSpeedBonus)
	$CanvasLayer/RArm/RARM/HBoxContainer/MarginContainer3/MarginContainer4/BoltCostRArmDamage.text = str(RArmDamageCost)
	$CanvasLayer/RArm/RARM/HBoxContainer/MarginContainer3/MarginContainer4/RArmDamageBonus.text = "+" + str(RArmDamageBonus)
	
	$CanvasLayer/Body/BODY/HBoxContainer/MarginContainer2/MarginContainer/BoltCostBodyHealth.text = str(BodyHealthCost)
	$CanvasLayer/Body/BODY/HBoxContainer/MarginContainer2/MarginContainer/BodyHealthBonus.text = "+" + str(BodyHealthBonus)
	$CanvasLayer/Body/BODY/HBoxContainer/MarginContainer3/MarginContainer2/BoltCostBodyEnergy.text = str(BodyEnergyCost)
	$CanvasLayer/Body/BODY/HBoxContainer/MarginContainer3/MarginContainer2/BodyEnergyBonus.text = "+" + str(BodyEnergyBonus)
	
	$CanvasLayer/BoltCount.text = str(bolts)

extends MarginContainer

#GUI Code taken from https://docs.godotengine.org/en/3.0/getting_started/step_by_step/ui_code_a_life_bar.html

#onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var healthbar = $Bars/LifeBar/NinePatchRect/HealthBar
onready var energybar = $Bars/LifeBar/NinePatchRect/EnergyBar
onready var tween = $Tween

var animated_health = 0
var animated_energy = 0

onready var main = get_parent().get_parent()
	
func init():
	var player_max_health = main.player.health
	var player_max_energy = main.player.energy
	healthbar.max_value = player_max_health
	energybar.max_value = player_max_energy
	updateHealth(player_max_health)
	updateEnergy(player_max_energy)
	self.rect_scale = main.get_view_scaling_factor()
	

func onHit(healthValue):
	updateHealth(healthValue)
	pass
	
func onAction(energyValue):
	updateEnergy(energyValue)
	pass

func updateHealth(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func updateEnergy(new_value):
	tween.interpolate_property(self, "animated_energy", animated_energy, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func _process(delta):
	var round_health = round(animated_health)
	healthbar.value = round_health
	
	var round_energy = round(animated_energy)
	energybar.value = round_energy

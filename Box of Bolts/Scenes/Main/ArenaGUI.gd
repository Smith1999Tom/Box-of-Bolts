extends MarginContainer

#GUI Code taken from https://docs.godotengine.org/en/3.0/getting_started/step_by_step/ui_code_a_life_bar.html

#onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var player_healthbar = $Bars/LifeBar/Player/VBoxContainer/HealthBar
onready var player_energybar = $Bars/LifeBar/Player/VBoxContainer/EnergyBar
onready var enemy_healthbar = $Bars/LifeBar/Enemy/VBoxContainer/HealthBar
onready var enemy_energybar = $Bars/LifeBar/Enemy/VBoxContainer/EnergyBar
onready var tween = $Tween

var player_animated_health = 0
var player_animated_energy = 0
var enemy_animated_health = 0
var enemy_animated_energy = 0

onready var main = get_parent().get_parent()
	
func init():
	var player_max_health = main.player.max_health
	var player_max_energy = main.player.max_energy
	var enemy_max_health = main.enemy.max_health
	var enemy_max_energy = main.enemy.max_energy
	
	player_healthbar.max_value = player_max_health
	player_energybar.max_value = player_max_energy
	enemy_healthbar.max_value = enemy_max_health
	enemy_energybar.max_value = enemy_max_energy
	
	updateHealth("Player", player_max_health)
	updateEnergy("Player", player_max_energy)
	updateHealth("Enemy", enemy_max_health)
	updateEnergy("Enemy", enemy_max_energy)
	self.rect_scale = main.scaleFactor
	

func onHit(name, healthValue):
	updateHealth(name, healthValue)
	pass
	
func onAction(name, energyValue):
	updateEnergy(name, energyValue)
	pass

func updateHealth(name, new_value):
	if(name == "Player"):
		tween.interpolate_property(self, "player_animated_health", player_animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	elif(name == "Enemy"):
		tween.interpolate_property(self, "enemy_animated_health", enemy_animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func updateEnergy(name, new_value):
	if(name == "Player"):
		tween.interpolate_property(self, "player_animated_energy", player_animated_energy, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	elif(name == "Enemy"):
		tween.interpolate_property(self, "enemy_animated_energy", enemy_animated_energy, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
func _process(delta):
	var player_round_health = round(player_animated_health)
	player_healthbar.value = player_round_health
	
	var player_round_energy = round(player_animated_energy)
	player_energybar.value = player_round_energy
	
	var enemy_round_health = round(enemy_animated_health)
	enemy_healthbar.value = enemy_round_health
	
	var enemy_round_energy = round(enemy_animated_energy)
	enemy_energybar.value = enemy_round_energy

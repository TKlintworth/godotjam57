extends Node2D

class_name PlayerCity

@onready var health = $Health
@onready var heal_timer = $HealTimer

@export var heal_time = 5
@export var heal_value = 5

var player_in_healing_zone = false


signal player_city_took_damage(damage_taken)
signal player_city_destroyed
signal player_heal(heal_value)

# Called when the node enters the scene tree for the first time.
func _ready():
	heal_timer.wait_time = heal_time
	#heal_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func apply_damage(attack: Attack):
	health.damage(attack)
	emit_signal("player_city_took_damage", attack.attack_damage)
	print("in player city apply damage")

func _on_player_city_destroyed():
	emit_signal("player_city_destroyed")

func _on_heal_timer_timeout():
	#print("heal timer timout, heal player")
	if(player_in_healing_zone):
		emit_signal("player_heal", heal_value)
	heal_timer.wait_time = heal_time
	heal_timer.start()

func _on_player_city_healing_radius_body_entered(body):
	print(body)
	if(body is Player):
		player_in_healing_zone = true
		heal_timer.wait_time = heal_time
		heal_timer.start()


func _on_player_city_healing_radius_body_exited(body):
	if(body is Player):
		player_in_healing_zone = false
		heal_timer.stop()

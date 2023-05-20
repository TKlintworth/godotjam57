extends Node2D

@export var max_health = 100
var health : int

@onready var health_bar = $TextureProgressBar

signal dead

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health

func damage(attack: Attack):
	health -= attack.attack_damage
	health_bar.value = health
	
	if health <= 0:
		#get_parent().queue_free()
		emit_signal("dead")

func heal(value):
	if(health + value > max_health):
		health = max_health
	else:
		health += value
	health_bar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

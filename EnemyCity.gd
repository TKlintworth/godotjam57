extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var level_up_timer = $LevelUpTimer
@onready var enemy_city_sprite_frames = $EnemyCitySpriteFrames
@onready var health_component = $Health

@export var spawn_time = 10
@export var level_up_time = 60
@export var settler_spawn_chance = 0.25
@export var currentLevel = 1

var isActive = false 
var isDestroyed = false
var maxLevel = 3


func apply_damage(damage):
	var new_attack = Attack.new()
	new_attack.attack_damage = damage
	health_component.damage(new_attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.wait_time = spawn_time
	level_up_timer.wait_time = level_up_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_health_dead():
	# Set to destroyed, stop timers, set to inactive, set sprite animation to destroyed, hide healthbar
	isDestroyed = true
	isActive = false
	spawn_timer.stop()
	level_up_timer.stop()
	health_component.visible = false
	enemy_city_sprite_frames.play("destroy")

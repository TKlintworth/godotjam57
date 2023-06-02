extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var level_up_timer = $LevelUpTimer
@onready var enemy_city_sprite_frames = $EnemyCitySpriteFrames
@onready var health_component = $Health
@onready var enemy = preload("res://scenes/enemy.tscn")
@onready var settler = preload("res://scenes/settler.tscn")
#@onready var settler = preload("")

@export var spawn_time = 10
@export var level_up_time = 120
@export var settler_spawn_chance = 0.25
@export var currentLevel = 1

@export var isActive = false 
var isDestroyed = false
var maxLevel = 3

func apply_damage(damage):
	var new_attack = Attack.new()
	new_attack.attack_damage = damage
	health_component.damage(new_attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	if(isDestroyed):
		enemy_city_sprite_frames.play("destroy")
		isActive = false
	elif(!isActive):
		visible = false
	spawn_timer.wait_time = spawn_time
	level_up_timer.wait_time = level_up_time
	randomize()

func build():
	# set active if not destroyed
	# play build animation
	if(!isDestroyed):
		# play build animation
		# enemy_city_sprite_frames.play("build")
		isActive = true
		visible = true

func level_up():
	if(currentLevel + 1 >= maxLevel):
		currentLevel = maxLevel
	else:
		currentLevel += 1
	print("new city level: " + str(currentLevel))

func spawn():
	var new_enemy 
	if(randf_range(0.0, 1.0) < settler_spawn_chance):
		new_enemy = settler.instantiate()
		new_enemy.set_pos(position)
		get_parent().add_child(new_enemy)
		print("Spawn Settler")
	else:
		new_enemy = enemy.instantiate()
		new_enemy.set_pos(position)
		get_parent().add_child(new_enemy)
		print("Spawn Enemy")
		#add_child(new_enemy) # Move outside the else once settlers are created
	# Create a new instance of an Enemy on the city
	# Chance to create an instance of Settler
	
func get_isActive():
	return isActive

func get_isDestroyed():
	return isDestroyed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(isActive):
		if(spawn_timer.is_stopped()):
			spawn_timer.start()
		if(level_up_timer.is_stopped()):
			level_up_timer.start()

func _on_health_dead():
	# Set to destroyed, stop timers, set to inactive, set sprite animation to destroyed, hide healthbar
	isDestroyed = true
	isActive = false
	AudioManager.play("res://assets/sounds/crumble.wav")
	spawn_timer.stop()
	level_up_timer.stop()
	health_component.visible = false
	enemy_city_sprite_frames.play("destroy")

func _on_level_up_timer_timeout():
	if(isActive):
		level_up()

func _on_spawn_timer_timeout():
	if(isActive):
		spawn()

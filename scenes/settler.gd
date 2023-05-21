extends Node2D

class_name Settler

@onready var EnemySprite = $EnemySprite
@onready var EnemyArea = $EnemyArea
@onready var EnemyCollisionBox = $EnemyArea/EnemyCollisionBox
@onready var HealthComponent = $Health
@onready var DetectionArea = $EnemySprite/DetectionArea

@export var health = 100
@export var speed = 0.2
@export var attackDamage = 10
@export var attackTime = 1.5

var Player = null

enum states { MOVE, FLEE, BUILD }
var enemyState = states.MOVE
var playerInAttackRange = false
var targetVector
var targetBuildSite 

# Called when the node enters the scene tree for the first time.
func _ready():
	print("settler created")
	
	Player = %Player
	
	if(PlayerCity or Player == null):
		Player = get_parent().find_child("Player")
		
	find_available_build_site()
	change_state(0)

func find_available_build_site():
	# Randomly choose an inactive, not destroyed EnemyCity to build at 
	if(!main.get_available_cities().is_empty()):
		targetBuildSite = main.get_available_cities().pick_random()
		print("found build site")
		print(targetBuildSite)
		main.update_available_cities(targetBuildSite)
	else:
		print("no available build sites")

func build_city():
	# Build the city, make it visible and set it to active
	if(targetBuildSite):
		targetBuildSite.build()
		queue_free()

func apply_damage(damage):
	var new_attack = Attack.new()
	new_attack.attack_damage = damage
	HealthComponent.damage(new_attack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match enemyState:
		0:
			#print("move")
			# Move towards the targetBuildSite
			if(targetBuildSite):
				targetVector = (targetBuildSite.position - position).normalized()
			else:
				change_state(1)
			position += targetVector * speed
		1:
			#print("flee")
			# Choose a random Vector within map bounds some distance away and go there
			pass
			position += targetVector * speed
		2:
			build_city()
			

func change_state(newState):
	if(newState == 0):
		enemyState = states.MOVE
	elif(newState == 1):
		enemyState = states.FLEE
	elif(newState == 2):
		enemyState = states.BUILD

func set_pos(newPos):
	position = newPos

func _on_health_dead():
	main.update_available_cities(targetBuildSite)
	queue_free()


func _on_enemy_area_area_entered(area):
	if(area.get_parent().is_in_group("city")):
		if(area.get_parent() == targetBuildSite):
			print("on top of inactive city, build please")
			change_state(2)

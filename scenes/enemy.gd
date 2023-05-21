extends Node2D

class_name Settler

@onready var EnemySprite = $EnemySprite
@onready var EnemyArea = $EnemyArea
@onready var EnemyCollisionBox = $EnemyArea/EnemyCollisionBox
@onready var HealthComponent = $Health
@onready var DetectionArea = $EnemySprite/DetectionArea
@onready var AttackTimer = $AttackTimer
#@onready var EnemyHealthBar = $EnemyHealthBar

@export var health = 100
@export var speed = 0.2
@export var attackDamage = 10
@export var attackTime = 1.5
#@export var PlayerCity : Node2D
#@export var Player : CharacterBody2D
#@export var Player = preload("res://scenes/player.tscn")
var PlayerCity = null
var Player = null

enum states { ATTACK, MOVE, FLEE, IDLE }
var enemyState = states.MOVE
var cityInAttackRange = false
var playerInAttackRange = false
var attackCooldownActive = false
var currentTarget = "PlayerCity"
var targetVector = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("enemy created")
	main.test()
	#print("main city: ", main.PlayerCity)
	#print("main player: ", main.Player)
	PlayerCity = %PlayerCity
	Player = %Player
	if(PlayerCity or Player == null):
		PlayerCity = get_parent().find_child("PlayerCity")
		Player = get_parent().find_child("Player")
	print("target: ", PlayerCity)
	AttackTimer.wait_time = attackTime

func apply_damage(damage):
	var new_attack = Attack.new()
	new_attack.attack_damage = damage
	HealthComponent.damage(new_attack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(enemyState == 0):
		attack()
		#position += Vector2(1,1) * speed 
	elif(enemyState == 1):
		#if(is_instance_valid(PlayerCity)):
		if(currentTarget == "Player"):
			targetVector = (Player.position - position).normalized()
		elif(currentTarget == "PlayerCity"):
			if(is_instance_valid(PlayerCity)):
				targetVector = (PlayerCity.position - position).normalized()
			else:
				currentTarget = "Player"
		position += targetVector * speed
		if(!EnemySprite.is_playing()):
			EnemySprite.play("enemy_walk")
	elif(enemyState == 2):
		print("flee")

func change_state(newState):
	if(newState == 0):
		enemyState = states.ATTACK
	elif(newState == 1):
		enemyState = states.MOVE
	elif(newState == 2):
		enemyState = states.FLEE
	else:
		enemyState = states.IDLE

func set_pos(newPos):
	position = newPos

func attack():
	if(!attackCooldownActive):
		if(cityInAttackRange or playerInAttackRange):
				var newAttack = Attack.new()
				newAttack.attack_damage = attackDamage
				if(cityInAttackRange):
					if(is_instance_valid(PlayerCity)):
						PlayerCity.apply_damage(newAttack)
				elif(playerInAttackRange):
					if(is_instance_valid(Player)):
						Player.health_component.damage(newAttack)
				print("enemy dealing damage")
				attackCooldownActive = true
				AttackTimer.start(attackTime)
		
	
		#print("waitingd")

func _on_detection_area_body_entered(body):
	print("body entered detection radius of enemy")
	if(body is Player):
		currentTarget = "Player"
		
func _on_detection_area_body_exited(body):
	print("body exited detection radius of enemy")
	if(body is Player):
		currentTarget = "PlayerCity"
	


func _on_enemy_area_area_entered(area):
	print("area entered enemy area")
	print(area.owner)
	if(area.is_in_group("hurtbox")):
		if(area.owner is PlayerCity):
			cityInAttackRange = true
			print("enemy within range of PlayerCity")
			change_state(0)
	#print(area.get_parent())


func _on_enemy_area_area_exited(area):
	if(area.is_in_group("hurtbox")):
		if(area.owner is PlayerCity):
			cityInAttackRange = false
			print("enemy lost range of PlayerCity")
			change_state(1)
		elif(area.owner is Player):
			playerInAttackRange = false
			print("enemy lost range of Player")
			if(is_instance_valid(PlayerCity)):
				currentTarget = "PlayerCity"
			change_state(1)


func _on_attack_timer_timeout():
	attackCooldownActive = false


func _on_enemy_area_body_entered(body):
	if(body is Player):
		playerInAttackRange = true
		print("enemy within range of Player")
		change_state(0)

func _on_health_dead():
	queue_free()

extends CharacterBody2D

class_name Player

@export var speed = 200
@export var health = 100
@export var attack_damage = 25
@export var charge_damage = 100

var attack_cooldown = 1
var block_cooldown = 5
var charge_cooldown = 10

@onready var player_camera = $PlayerCamera
#@onready var health_bar = $PlayerHealthBar
@onready var attack_hitbox_right = $PlayerSprite/PlayerAttackBox/PlayerAttackBoxRight
@onready var attack_hitbox_left = $PlayerSprite/PlayerAttackBox/PlayerAttackBoxLeft
@onready var player_sprite = $PlayerSprite
@onready var attack_timer = $AttackTimer
@onready var block_timer = $BlockTimer
@onready var charge_timer = $ChargeTimer
@onready var health_component = $Health

#var Attack = preload("res://Attack.gd")

signal player_dead

var attack_animation_playing = false
var attack_target 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func attack(attack: Attack):
	player_sprite.play("player_attack")
	attack_animation_playing = true

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	#print(velocity)
	if(Input.is_action_just_pressed("player_attack")):
		var new_attack = Attack.new()
		new_attack.attack_damage = attack_damage
		attack(new_attack)
		
	elif(abs(velocity) > Vector2.ZERO):
		if velocity.normalized().x < 0:
			player_sprite.flip_h = true
		elif velocity.normalized().x > 0:
			player_sprite.flip_h = false
		if (!attack_animation_playing):
			player_sprite.play("player_walk")
	else:
		if (!attack_animation_playing):
			player_sprite.play("player_idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if(!player_sprite.flip_h):
		attack_hitbox_right.disabled = not attack_animation_playing or player_sprite.frame not in [3,4,5,6]
	else:
		attack_hitbox_left.disabled = not attack_animation_playing or player_sprite.frame not in [3,4,5,6]
		
	get_input()
	move_and_slide()


func _on_player_sprite_animation_finished():
	#print("finished")
	if(player_sprite.animation == "player_attack"):
		attack_animation_playing = false
		#attack_target = false
	#print(player_sprite.animation)


func _on_player_attack_box_area_entered(area):
	if(!(area.owner is PlayerCity)): #and !attack_target):
		#attack_target = true
		if(area.is_in_group("hurtbox")):
			area.get_parent().apply_damage(50)
		#if(area.is_in_group("hurtbox")):
		#	print("hit by player")
			


func _on_player_city_player_heal(heal_value):
	#print("player healing")
	health_component.heal(heal_value)


func _on_health_dead():
	emit_signal("player_dead")

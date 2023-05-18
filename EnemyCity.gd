extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var level_up_timer = $LevelUpTimer
@onready var enemy_city_sprite_frames = $EnemyCitySpriteFrames

@export var spawn_time = 10
@export var level_up_time = 60
@export var settler_spawn_chance = 0.25

var isActive = false 
var isDestroyed = false
var currentLevel = 1
var maxLevel = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.wait_time = spawn_time
	level_up_timer.wait_time = level_up_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

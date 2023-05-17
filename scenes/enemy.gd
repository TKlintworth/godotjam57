extends Node2D

@onready var EnemySprite = $EnemySprite
@onready var EnemyArea = $EnemyArea
@onready var EnemyCollisionBox = $EnemyArea/EnemyCollisionBox
@onready var EnemyHealthBar = $EnemyHealthBar

@export var health = 100
@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

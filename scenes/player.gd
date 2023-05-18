extends CharacterBody2D

@export var speed = 200
@export var health = 100

@onready var player_camera = $PlayerCamera
@onready var health_bar = $PlayerHealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	print(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	move_and_slide()

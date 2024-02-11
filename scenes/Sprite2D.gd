extends Node2D

@export var speed = 10
var velocity

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	position += velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	get_input()
	#move_and_slide()extends Sprite2D

extends Node2D

@onready var hud = $HUD
@export var game_length_in_seconds : int = 6 # 6000 = 10 minutes

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	#hud.start_game_timer()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func game_over():
	print("game has ended")

func game_start():
	pass


func _on_hud_game_timer_timeout():
	print("game timer timeout")
	hud.stop_game_timer()
	game_over()


func _on_hud_start_game_pressed():
	print("start game button pressed")
	hud.set_game_timer(game_length_in_seconds)
	hud.start_game_timer()

extends Node2D

@onready var hud = get_node("HUD")
@export var game_length_in_seconds : int = 10 # 6000 = 10 minutes
@export var Player : CharacterBody2D 
@export var PlayerCity : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
	#hud.start_game_timer()
	
func test():
	print("test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func game_over(status):
	print("game has ended")
	print(status)
	if(status == "victory"):
		hud.set_game_over_text("You won!")
	else:
		hud.set_game_over_text("Your base was destroyed, you lost!")

func game_start():
	pass




func _on_hud_game_timer_timeout():
	print("game timer timeout")
	hud.stop_game_timer()
	game_over("victory")


func _on_hud_start_game_pressed():
	print("start game button pressed")
	hud.set_game_timer(game_length_in_seconds)
	hud.start_game_timer()


func _on_player_city_player_city_took_damage():
	print("city took damage main")


func _on_player_city_destroyed():
	print("player city destroyed")
	game_over("failure")


func _on_player_player_dead():
	print("player died")
	game_over("failure")

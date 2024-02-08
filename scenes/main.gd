extends Node2D

@onready var hud = $HUD
@onready var overlay_rect = $OverlayRect
#@onready var overlay_viewport = $SubViewportContainer/OverlayViewport
@export var game_length_in_seconds : int = 300 # 6000 = 10 minutes
@export var Player : CharacterBody2D 
@export var PlayerCity : Node2D

var available_cities = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#process_mode = Node.PROCESS_MODE_ALWAYS
	if($"/root/Main/HUD"):
		print($"/root/Main/HUD")
	#hud.start_game_timer()
	# Assuming $OverlayViewport is your drawing viewport and $Overlay is the TextureRect for displaying the trail
	if(overlay_rect):
		# Create a new Image
		# Ensure the image is created and filled correctly
		var image = Image.create(512, 512, false, Image.FORMAT_RGBA8)

		# Fill the image with a completely transparent color
		image.fill(Color.TRANSPARENT)

		# Create an ImageTexture from the Image
		var texture = ImageTexture.new()
		texture.create_from_image(image)

		# Assign the ImageTexture to the TextureRect
		var texture_rect = $SubViewportContainer/OverlayViewport/TextureRect
		texture_rect.texture = texture
			
			
		var overlay_viewport = $SubViewportContainer/OverlayViewport
		overlay_viewport.CLEAR_MODE_NEVER
		var viewport_texture = overlay_viewport.get_texture()
		#viewport_texture.viewport_path = $OverlayViewport
		var overlay_texture_rect = $OverlayRect  # This TextureRect should be outside the OverlayViewport, positioned to overlay the scene
		#overlay_texture_rect.texture = viewport_texture

func pause():
	$"/root/Main/HUD".find_child("CenterContainer2").visible = true
	get_tree().paused = true

func unpause():
	$"/root/Main/HUD".find_child("CenterContainer2").visible = false
	get_tree().paused = false

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if(get_tree().paused):
		$"/root/Main/HUD".find_child("CenterContainer2").visible = true
	else:
		$"/root/Main/HUD".find_child("CenterContainer2").visible = false

func test():
	print("test")

func get_available_cities():
	var cities = get_tree().get_nodes_in_group("city")
	for city in cities:
		if(!city.get_isActive()):
			available_cities.append(city)
	return available_cities

func update_available_cities(city):
	if(city in available_cities):
		available_cities.erase(city)
	else:
		available_cities.append(city)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Player):
		#overlay_sprite.material.set_shader_parameter("character_pos", Player.position)
		#overlay_sprite.material.set_shader_parameter("radius", 10)
		$SubViewportContainer/OverlayViewport/TextureRect.material.set_shader_parameter("character_pos", Player.position)
		print($SubViewportContainer/OverlayViewport/TextureRect.material.get_shader_parameter("character_pos"))
		$SubViewportContainer/OverlayViewport/TextureRect.material.set_shader_parameter("radius", 10)
		print($SubViewportContainer/OverlayViewport/TextureRect.material.get_shader_parameter("radius"))
		#overlay_rect.material.set_shader_parameter("character_pos", Player.position)
		#overlay_rect.material.set_shader_parameter("radius", 10)
	
func game_over(status):
	print("game has ended")
	print(status)
	if(status == "victory"):
		$"/root/Main/HUD".set_game_over_text("You won!")
	else:
		$"/root/Main/HUD".set_game_over_text("Your base was destroyed, you lost!")

func game_start():
	$"/root/Main/HUD".set_game_timer(game_length_in_seconds)
	$"/root/Main/HUD".start_game_timer()




func _on_hud_game_timer_timeout():
	print("game timer timeout")
	$"/root/Main/HUD".stop_game_timer()
	game_over("victory")


func _on_hud_start_game_pressed():
	print("signal start")
	print("start game button pressed")
	AudioManager.play("res://assets/sounds/feudal_final.wav")
	#print(hud)
	$"/root/Main/HUD".set_game_timer(game_length_in_seconds)
	$"/root/Main/HUD".start_game_timer()
	unpause()
		


func _on_player_city_player_city_took_damage():
	print("city took damage main")


func _on_player_city_destroyed():
	print("player city destroyed")
	game_over("failure")


func _on_player_player_dead():
	print("player died")
	game_over("failure")


func _on_ready():
	
	$"/root/Main/HUD".find_child("CenterContainer2").visible = false
	#get_tree().paused = true

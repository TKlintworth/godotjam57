extends CanvasItem

#var fog_brush: Texture = preload("res://assets/sprites/fog_black_74x69.png")

# Store reference to the player node
@export var player : CharacterBody2D
var draw_offset = Vector2(50, 0)

var fog_positions = []
var erase_positions = []

func _ready():
	pass
	#player = get_node("player")

func _process(delta):
	# Check the player's state and position.
	if player.fog_state == "fog_draw":
		fog_positions.append(player.position + draw_offset)
	elif player.fog_state == "fog_erase":
		erase_positions.append(player.position)
	queue_redraw()
	# Check player's state and position
	#if player.fog_state == "fog_draw":
		#draw_texture(fog_brush, player.position - fog_brush.get_size() / 2, Color.black)
	#	draw_texture(fog_brush, player.position + draw_offset - fog_brush.get_size() / 2)
	#elif player.fog_state == "fog_erase":
	#	pass
		#draw_texture(fog_brush, player.position - fog_brush.get_size() / 2, Color.transparent)

func _draw():
	#draw_texture(fog_brush, player.position - fog_brush.get_size() / 2, Color.TRANSPARENT)
	pass
	# Draw fog at the positions stored in fog_positions.
	#for position in fog_positions:
		#draw_texture(fog_brush, position - fog_brush.get_size() / 2, Color.BLACK)

	# Erase fog at the positions stored in erase_positions.
	#for position in erase_positions:
		#draw_texture(fog_brush, position - fog_brush.get_size() / 2, Color.TRANSPARENT)


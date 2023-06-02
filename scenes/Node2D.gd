extends Node2D

var mask_texture_path = "res://path/to/your/mask_texture.png"  # Add the correct path here
var stamp_texture_path = "res://path/to/your/stamp_texture.png"  # Add the correct path here

@export var mask_texture : ImageTexture
var mask_image : Image

@export var stamp_texture : ImageTexture
var stamp_image : Image

var player : CharacterBody2D

var is_erasing : bool = false

var brush_size : int = 16

func _ready():
	var mask_stream_texture = load(mask_texture_path)
	mask_image = mask_stream_texture.get_data()
	mask_texture = ImageTexture.new()
	mask_texture.create_from_image(mask_image)

	var stamp_stream_texture = load(stamp_texture_path)
	stamp_image = stamp_stream_texture.get_data()
	stamp_texture = ImageTexture.new()
	stamp_texture.create_from_image(stamp_image)

func _process(delta):
	stamp(player.global_position, is_erasing)

func stamp(position : Vector2, erase : bool):
	# Convert global position to mask texture position
	var tex_pos = position / mask_texture.get_size()

	# Convert texture position to image position
	var img_pos = tex_pos * mask_image.get_size()

	# Adjust for brush size
	var start = img_pos - Vector2(brush_size, brush_size)
	var end = img_pos + Vector2(brush_size, brush_size)

	# Clamp to image bounds
	start = start.clamp(Vector2.ZERO, mask_image.get_size())
	end = end.clamp(Vector2.ZERO, mask_image.get_size())

	var value = erase if 0 else 255

	# Update mask image
	for x in range(int(start.x), int(end.x)):
		for y in range(int(start.y), int(end.y)):
			# Calculate relative position within the stamp image
			var stamp_pos = Vector2(x, y) - start
			stamp_pos = stamp_pos / (end - start) * stamp_image.get_size()

			# Get the alpha value of the stamp image at this position
			var stamp_alpha = stamp_image.get_pixel(int(stamp_pos.x), int(stamp_pos.y)).a

			# Apply the stamp alpha to the mask image
			var old_pixel = mask_image.get_pixel(x, y)
			var new_alpha = (1.0 - stamp_alpha) * old_pixel.a + stamp_alpha * value
			var new_pixel = Color(old_pixel.r, old_pixel.g, old_pixel.b, new_alpha)
			mask_image.set_pixel(x, y, new_pixel)

	# Update mask texture
	mask_texture = ImageTexture.new()
	mask_texture.create_from_image(mask_image)

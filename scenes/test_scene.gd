extends Node2D

func _process(delta):
	$Control/SubViewport/Sprite2D.material.set_shader_parameter("radius", 10)
	$Control/SubViewport/Sprite2D.material.set_shader_parameter("character_pos", $Sprite2D.position)

func _ready():
	var image = Image.create(512, 512, false, Image.FORMAT_RGBA8)
	# Fill the image with a completely transparent color
	image.fill(Color.INDIAN_RED)
	# Create an ImageTexture from the Image
	var texture = ImageTexture.new()
	$OverlayRect.texture = texture.create_from_image(image)
	$OverlayRect.width = int(get_viewport().get_visible_rect().size.x)

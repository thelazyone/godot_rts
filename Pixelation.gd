extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var material : ShaderMaterial = get_node("PixelScreen").get_material()
	material.set_shader_parameter("pixelSize", 4);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_pixel_offset(offset):
	get_node("PixelScreen").get_material().set_shader_parameter("pixelOffset", offset);

extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var material : ShaderMaterial = get_node("Pixelation/PixelScreen").get_material()
	material.set_shader_parameter("pixelSize", 4);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

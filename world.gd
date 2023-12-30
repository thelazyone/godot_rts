extends Node3D




# Called when the node enters the scene tree for the first time.
func _ready():
	var material : ShaderMaterial = get_node("Pixelation/PixelScreen").get_material()
	material.set_shader_parameter("pixelSize", 4);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

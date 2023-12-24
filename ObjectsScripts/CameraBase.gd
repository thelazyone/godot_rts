extends Node3D


func coords_on_xz(screen_position):
	var z0_plane  = Plane(Vector3(0, 1, 0), 0)
	var camera_obj = get_node("Camera3D")
	return z0_plane.intersects_ray(
							 camera_obj.project_ray_origin(screen_position),
							 camera_obj.project_ray_normal(screen_position))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var camera_obj = get_node("Camera3D")
	var camera_speed = 2
	var camera_speed_x = camera_obj.size * camera_speed / camera_obj.get_window().size.y
	var camera_speed_z = camera_obj.size * camera_speed / (camera_obj.get_window().size.y * sin(camera_obj.rotation[0]))
	
	if Input.is_action_pressed("ui_right"):
		camera_obj.position.x += camera_speed_x
		
	if Input.is_action_pressed("ui_left"):
		camera_obj.position.x -= camera_speed_x
		
	if Input.is_action_pressed("ui_down"):
		camera_obj.position.z -= camera_speed_z
		
	if Input.is_action_pressed("ui_up"):
		camera_obj.position.z += camera_speed_z

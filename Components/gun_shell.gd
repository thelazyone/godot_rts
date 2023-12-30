extends CharacterBody3D

var targetDestination = Vector2(0, 0)
@export var speed = 10
@export var lifetime = 1000
@export var start_show = 150

var spawn_time = Time.get_ticks_msec()
var shell_offset = Vector2(0, 0)


func set_shell_offset(i_offset):
	position = Vector3(i_offset)

func set_target(i_position, i_optimal_target, i_scatter_radius):
	targetDestination = i_optimal_target + Vector2(1, 0).rotated(randf_range(0, 2*PI)) * randf_range(0, i_scatter_radius)
	velocity = Vector3(speed, 0, 0).rotated(Vector3(0,1, 0), -i_position.angle_to_point(targetDestination))


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.


func _physics_process(delta):
	var elapsed = Time.get_ticks_msec() - spawn_time
	visible = elapsed > start_show
	get_node("CollisionShape3D").disabled = !visible

	# If hits something, it disappears
	if get_slide_collision(0) != null:
		var target = get_slide_collision(get_slide_collision_count() - 1)
		queue_free()
		print("collision is ", target)

	# Bullet disappears after maximum range @TODO should explode?
	if elapsed > lifetime:
		queue_free()
		
	move_and_slide()
	pass


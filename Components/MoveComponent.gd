extends Node3D

enum ActionStates {
	Idle, 			# Doing Nothing
	Moving, 		# Reaching point x,y
	Following,		# Following something with ID
	Interacting,	# Either reaching something with ID or - if reached - interacting.
	}
	
var state = ActionStates.Idle
var target = Vector2(0, 0)
var plane_direction = 0
var plane_position = Vector2(0, 0)

# Constants. To be updated after this.
@export var SPEED = 3
@export var ROT_SPEED = 5
@export var MIN_ANGLE_MOVE = PI / 4

var target_distance_threshold = 0.1

# Temp function, i'm sure there's a prebuild one.
func diff_angles(angle1, angle2):
	return fmod(fmod(angle1, 2 * PI) - fmod(angle2, 2 * PI) + 3 * PI, 2 * PI) - PI


# Movement towards target - TODO check for collisions using Godot tools
func _move_towards(target, delta):
	
	# First rotating if not rotated.
	var target_direction = plane_position.angle_to_point(target)
	
	plane_direction += clamp(diff_angles(target_direction, plane_direction), -ROT_SPEED * delta, ROT_SPEED * delta)
	
	# If the difference in angle is not excessive
	if abs(diff_angles(target_direction, plane_direction)) < MIN_ANGLE_MOVE:
		plane_position.x +=  SPEED * cos(plane_direction) * delta
		plane_position.y +=  SPEED * sin(plane_direction) * delta
	
	_update_transforms()
		

func _update_transforms():
	get_parent().position = Vector3(plane_position.x, 0, plane_position.y)
	get_parent().rotation = Vector3(0, -plane_direction, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Setting up tank")
	plane_position = Vector2(get_parent().position.x, get_parent().position.z)
	print("Position is ",plane_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Trying to move towards target
	if plane_position.distance_to(target) > target_distance_threshold:
		_move_towards(target, delta)
	
	pass

# Public Functions Here
func command_move(target3d):
	
	# Setting the State Machine
	# TODO - for now let's assume the object is always moving
	
	# Setting the target
	target = Vector2(target3d.x, target3d.z)

extends Node3D

enum ActionStates {
	Idle, 			# Doing Nothing
	Moving, 		# Reaching point x,y
	Following,		# Following something with ID
	Interacting,	# Either reaching something with ID or - if reached - interacting.
	}
	
var state = ActionStates.Idle
var target = Vector2(0, 0)
var target_obj = null
var plane_direction = 0
var plane_position = Vector2(0, 0)

# Constants. To be updated after this.
@export var SPEED = 200
@export var ROT_SPEED = 5
@export var MIN_ANGLE_MOVE = PI / 4

var target_distance_threshold = 0.1
var interaction_range = 0.5

# Movement towards target - TODO check for collisions using Godot tools
func _move_towards(target, delta, threshold):
	
	# Resetting velocity to default:
	get_parent().velocity.x = 0
	get_parent().velocity.z = 0
		
	# If the distance is small enough, skipping the move.
	if plane_position.distance_to(target) < target_distance_threshold:
		return false
	
	# First rotating if not rotated.
	var target_direction = plane_position.angle_to_point(target)
	
	plane_direction += clamp(Geometry.diff_angles(target_direction, plane_direction), -ROT_SPEED * delta, ROT_SPEED * delta)
	
	# If the difference in angle is not excessive
	if abs(Geometry.diff_angles(target_direction, plane_direction)) < MIN_ANGLE_MOVE:
		get_parent().velocity.x = SPEED * cos(plane_direction) * delta
		get_parent().velocity.z = SPEED * sin(plane_direction) * delta
	
	_update_transforms()
	return true

func _interact_with(target, delta, range):
	
	# TODO return false if the interaction is not necessary anymore.
	
	return true

func _update_transforms():
	get_parent().rotation = Vector3(0, -plane_direction, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	plane_position = Vector2(get_parent().position.x, get_parent().position.z)
	print("Setting up tank at ", plane_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Updating the plane position

	plane_position = Vector2(get_parent().position.x, get_parent().position.z)
	#print("Position set to ", plane_position)
		
	if state == ActionStates.Idle:
		pass
	
	elif state == ActionStates.Moving:
		if !_move_towards(target, delta, target_distance_threshold):
			command_stop()
		
	elif state == ActionStates.Interacting:
		# Updating the target, moving toward, then trying to interact if in range
		if target_obj == null: 
			print ("Target is null and state is Following!")
		else:
			target = Vector2(target_obj.position.x, target_obj.position.z) 
		_move_towards(target, delta, target_distance_threshold)
		if !_interact_with(target, delta, interaction_range):
			command_stop()
	
	elif state == ActionStates.Following:
		# Updating the target position then moving.
		if target_obj == null: 
			print ("Target is null and state is Following!")
		else:
			target = Vector2(target_obj.position.x, target_obj.position.z) 
		_move_towards(target, delta, target_distance_threshold)
		
	pass

# Public Functions Here
func command_move(i_target):
	state = ActionStates.Moving
	target = i_target
	print ("Send command Move towards", i_target)
	
func command_interact(i_target_obj):
	# TODO check if target is a valid target.
	state = ActionStates.Interacting
	target_obj = i_target_obj
	target = Vector2(target_obj.position.x, target_obj.position.z)
	print ("Send command Interact")
	
func command_stop():
	state = ActionStates.Idle
	target = Vector2(0, 0)
	print ("Send command Stop")
	
func command_follow(i_target_obj):
	# TODO check if target is a valid target.
	state = ActionStates.Following
	target_obj = i_target_obj
	target = Vector2(target_obj.position.x, target_obj.position.z)
	print ("Send command Follow")
	

extends Node3D

@export var HAS_TURRET = false
@export var ROT_SPEED = 4

# Combat State:
enum CombatStates {
	Idle, 			# Doing Nothing
	Searching,		# Waiting for a target to attack
	Aiming, 		# Not attacking, but aiming at a specific point (for debug at least)
	Attacking,		# Attacking a target somehow
	}
	
var state = CombatStates.Idle
var plane_target = Vector2(0, 0)
var plane_position = Vector2(0, 0)
var turret_direction = 0

# Temp function, i'm sure there's a prebuild one.
func diff_angles(angle1, angle2):
	return fmod(fmod(angle1, 2 * PI) - fmod(angle2, 2 * PI) + 3 * PI, 2 * PI) - PI


# Called when the node enters the scene tree for the first time.
func _ready():
	plane_position = Vector2(get_parent().position.x, get_parent().position.z)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	plane_position = Vector2(get_parent().position.x, get_parent().position.z)
	
	# Rotating the turret, if any.
	if HAS_TURRET:
		var target_direction = 0
		if state == CombatStates.Aiming or state == CombatStates.Attacking:
			target_direction = -plane_position.angle_to_point(plane_target)
		else:
			target_direction = get_parent().rotation.y
			
		turret_direction += clamp(diff_angles(target_direction, turret_direction), -ROT_SPEED * delta, ROT_SPEED * delta)
	pass

# State commands
func combat_aim(coordinates):
	state = CombatStates.Aiming
	plane_target = coordinates
	
func combat_stop():
	state = CombatStates.Idle
	plane_target = Vector2(0, 0)

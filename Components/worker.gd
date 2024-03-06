extends CharacterBody3D

# Selection flag
var is_selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Nothing to do here for now.
	pass 


func _physics_process(delta):
	move_and_collide(velocity * delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Note that the CombatComponent in this case only direct the turret when building stuff.
	# A "building" kind of projectile can then be used to just show that the worker is building.
	get_node("Turret").rotation = Vector3(0, get_node("CombatComponent").turret_direction - rotation.y, 0)
	pass


# TODO find a smart way to pass through this layer without having to re-write the commands?

func command_move(target):
	get_node("MoveComponent").command_move(target)


# Selection methods
func select(bool_value):
	is_selected = bool_value
	get_node("Selected").visible = is_selected
	
	
func combat_aim(target):
	get_node("CombatComponent").combat_aim(target)
	
	
func combat_stop():
	get_node("CombatComponent").combat_stop()	

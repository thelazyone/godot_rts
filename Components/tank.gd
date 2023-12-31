extends CharacterBody3D


var is_selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	# Previously using move_and_slide, but sliding looks very weird on tracked vehicles
	move_and_collide(velocity * delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# TANK-Specific functions, like rotating the turret
	get_node("Turret").rotation = Vector3(0, get_node("CombatComponent").turret_direction - rotation.y, 0)
	pass

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
	
	
func combat_attack_area(target):
	get_node("CombatComponent").combat_attack_area(target)
	

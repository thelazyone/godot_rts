extends Node3D

# Creating a reference to the other useful parts. The @onready holds the definition until the 
# _ready function has been called and the system initialized.
@onready var m_UnitsControlNode = get_node("../UnitsControl")
@onready var m_Camera = get_node("../CameraBase")

#func ProjectOnPlane(coords2D):
	#return Vector3(coords2D.x, 0, coords2D.y)
var tanks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	m_UnitsControlNode.movement_order.connect(go_to)
	m_UnitsControlNode.area_selected.connect(select_actors)
	m_UnitsControlNode.aim_order.connect(aim_to)
	add_tank(4,4)
	add_tank(2,4)
	add_tank(0,4)
	add_tank(-2,4)
	add_tank(-4,4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_tank(x, y): # Clearly temp:
	var new_tank = preload("res://Components/tank.tscn").instantiate()
	new_tank.position.x = x
	new_tank.position.z = y
	add_child(new_tank)


# Callbacks
func go_to(coordinate):
	for child in get_children():
		if "is_selected" in child and child.is_selected:
			child.command_move(m_Camera.coords_on_xz(coordinate))


func select_actors(start, end):
	var plane_start = m_Camera.coords_on_xz(start)
	var plane_end = m_Camera.coords_on_xz(end)
	for child in get_children():
		if child.has_method("select"):
			# STUPID method, clearly not the correct one.
			var select_value = child.position.x > plane_start.x and child.position.x < plane_end.x and child.position.z > plane_start.y and child.position.z < plane_end.y
			child.select(select_value)
			print ("child is in ", child.position,", selected ", plane_start, " " , plane_end, ". selection is ", select_value )
			
func aim_to(coordinate):
	for child in get_children():
		if "is_selected" in child and child.is_selected:
			child.combat_aim(m_Camera.coords_on_xz(coordinate))
		else:
			child.combat_stop()



















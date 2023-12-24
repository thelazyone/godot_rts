extends Node3D

# Creating a reference to the other useful parts. The @onready holds the definition until the 
# _ready function has been called and the system initialized.
@onready var m_UnitsControlNode = get_node("../UnitsControl")
@onready var m_Camera = get_node("../CameraBase")

#func ProjectOnPlane(coords2D):
	#return Vector3(coords2D.x, 0, coords2D.y)
	#

# Called when the node enters the scene tree for the first time.
func _ready():
	m_UnitsControlNode.movement_order.connect(GoTo)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func GoTo(coordinate):
	# For now just printing on console
	get_node("Tank").position = m_Camera.coords_on_xz(coordinate)

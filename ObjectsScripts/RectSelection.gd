extends CanvasLayer


# Rectangle handling.
var rectStart = Vector2()
var isDragging = false # Maybe useless TODO TBR
var mousePos = Vector2()

# Rectangle signals
signal area_selected(start_point, end_point)
signal movement_order(location)

func draw_area(show = true):
	var rectangle = get_node("./Rect")
	rectangle.visible = show
	if show:
		rectangle.position = Vector2(min(rectStart.x, mousePos.x), min(rectStart.y, mousePos.y))
		rectangle.size = Vector2(abs(rectStart.x - mousePos.x), abs(rectStart.y - mousePos.y))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	if event is InputEventMouse:
		mousePos = event.position
		draw_area(isDragging)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		rectStart = mousePos
		isDragging = true
	
	if Input.is_action_just_released("LeftClick"):
		# TODO send area_selected
		print("Area Selected: ", rectStart, mousePos)
		isDragging = false
		
	if Input.is_action_just_pressed("RightClick"):
		movement_order.emit(get_viewport().get_mouse_position())
	
	pass

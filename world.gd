extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Connecting Buttons to Actors spawner
	
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _input(event):
	
	# Quit on "Esc"
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

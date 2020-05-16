extends Position2D

var mouse_loc 

func _physics_process(delta):
	mouse_loc = get_global_mouse_position()

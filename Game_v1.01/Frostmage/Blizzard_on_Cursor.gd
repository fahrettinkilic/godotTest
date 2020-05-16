extends KinematicBody2D

var deneme = Vector2.ZERO
export var ACCELERATION = 1000
export var FRICTION = 1000
export var MAX_SPEED = 250
var velocity = Vector2.ZERO

func _physics_process(delta):
	move_and_slide(deneme)
	var input_vector_b = Vector2.ZERO
	input_vector_b = (get_global_mouse_position() - self.position).normalized()
	
	if input_vector_b != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector_b * MAX_SPEED, ACCELERATION * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func move():
	velocity = move_and_slide(velocity)

func _ready():
	pass

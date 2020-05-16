extends RigidBody2D

export (int) var speed = 10
var direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity
	
func set_direction(direction: Vector2):
	self.direction = direction

func _on_Area2D_body_entered(_body):
	queue_free()

func _on_Area2D_area_entered(area):
	queue_free()
	

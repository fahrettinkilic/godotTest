extends RigidBody2D

func _physics_process(_delta):
	pass

func _ready():
	pass 

func _on_Area2D_body_entered(_body):
	pass

func _on_AnimationPlayer_animation_finished():
	self.queue_free()

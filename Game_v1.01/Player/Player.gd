extends KinematicBody2D

enum {
	MOVE,
	ROLL,
	ATTACK
}

export (PackedScene) var Bullet
export var fire_rate = 0.5
export var magazine = 10
export var reload_rate = 2.5
export var ACCELERATION = 1000
export var FRICTION = 1000
export var MAX_SPEED = 250
export var teleport_rate = 30
export var inst_health = 10
export var damage = 3

onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var hurtbox = $HurtBox
var bullet = preload("res://Bullet/Bullet.tscn")
var can_reload = true
var can_hurt = true
var hurt_rate = 0.5
var ROLL_SPEED = 100
var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var bullet_speed = 2500
var can_teleport = true
var can_fire = true
var stats = PlayerStats

onready var end_of_gun = $EndofGun

func _physics_process(delta):
	look_at(get_global_mouse_position())

	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			pass

	if Input.is_action_just_pressed("fire"):
		fire()

	if Input.is_action_just_pressed("hurt"):
		hurt()

	if Input.is_action_just_pressed("reload"):
		reload()

func move():
	velocity = move_and_slide(velocity)

func move_state(delta):

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()

func hurt():

	print("HURT")
	can_hurt = false
	inst_health = inst_health - damage
	stats.health = inst_health
	$Hurt.play()
	yield(get_tree().create_timer(hurt_rate), "timeout")
	can_hurt = true
	if inst_health <= 0:
		queue_free()
		print("DEAD")

func fire():
	if can_fire == true and can_reload == true:
		var bullet_instance = bullet.instance()
		bullet_instance.position = end_of_gun.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		magazine = magazine - 1
		stats.bullet = magazine
		$Shot.play()
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	if magazine <= 0:
		can_fire = false

func reload():
	if can_reload == true:
		can_fire = false
		can_reload = false
		yield(get_tree().create_timer(reload_rate), "timeout")
		magazine = 10
		can_fire = true
		stats.bullet = magazine
		can_reload = true

func _on_Portal1_body_entered(body):
	if can_teleport == true:
		body.position = get_node("../Portal2").position
		$Teleport.play()
		can_teleport = false
		yield(get_tree().create_timer(teleport_rate), "timeout")
		print("portal1 entered")
		can_teleport = true

func _on_Portal2_body_entered(body):
	if can_teleport == true:
		body.position = get_node("../Portal1").position
		$Teleport.play()
		can_teleport = false
		yield(get_tree().create_timer(teleport_rate), "timeout")
		print("portal2 entered")
		can_teleport = true

func _on_HurtBox_area_entered(area):
	hurt()
	print("icinde")
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()

func _on_HurtBox_invincibility_started():
	blinkAnimationPlayer.play("Start")
	print("vurdu")

func _on_HurtBox_invincibility_ended():
	blinkAnimationPlayer.play("End")
	print("hazir")

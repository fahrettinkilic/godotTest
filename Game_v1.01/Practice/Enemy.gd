extends KinematicBody2D


export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,

	WANDER,

	CHASE	
}

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var state = CHASE 

#onready var animationPlayer = $AnimationPlayer
#onready var sprite = $AnimatedSprite
onready var stats = PlayerStats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $HurtBox
#onready var softCollision = $SoftCollision
#onready var wanderController = $WanderController

func _ready():
	state = pick_random_state([IDLE, WANDER])

func update_wander():
	state = pick_random_state([IDLE, WANDER])
#	wanderController.start_wander_timer(rand_range(1, 3))

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

	match state:
		IDLE:
			pass

		WANDER:
			pass
#			seek_player()
#			if wanderController.get_time_left() == 0:
#				update_wander()
#			accelerate_towards_point(wanderController.target_position, delta)
#
#			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
#				update_wander()

		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)

			else:
				state = IDLE

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func seek_player():
	pass
#	if playerDetectionZone.can_see_player():
##		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(2)

func _on_Stats_no_health():
	queue_free()

func _on_Hurtbox_invincibility_started():
	pass
#	animationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	pass
#	animationPlayer.play("Stop")

func _on_HitBox_area_entered(area):
	queue_free()

extends "res://Player/Player.gd"

const Cooldown = preload("res://Frostmage/Cooldowns.gd")

onready var skill2_cd = Cooldown.new(10)
onready var skill1_cd = Cooldown.new(10)
onready var blink_cd = Cooldown.new(10)

export var blink_range = 300

func _ready():
	pass
	print("rogue")

func _physics_process(delta):
	skill2_cd.tick(delta)
	skill1_cd.tick(delta)
	blink_cd.tick(delta)
	
	if Input.is_action_just_pressed("blink") and blink_cd.is_ready():
		blink()
	if Input.is_action_just_pressed("skill1") and skill1_cd.is_ready():
		fast_attack()
	if Input.is_action_just_pressed("skill2") and skill2_cd.is_ready():
		bleed_attack()

func blink():
	get_node("PowerBar/BlinkCDBar/RightBR_1").visible = false
	if get_node("PowerBar/BlinkCDBar/CDProgressBar").value > 0:
		get_node("PowerBar/BlinkCDBar/CDProgressBar").value = 0
	var blink_direction = (get_global_mouse_position() - self.position).normalized()
	self.position = self.position + blink_direction * blink_range 

func fast_attack():
	var i = 3
	get_node("PowerBar/Skill1CDBar/RightBR_1").visible = false
	if get_node("PowerBar/Skill1CDBar/CDProgressBar").value > 0:
		get_node("PowerBar/Skill1CDBar/CDProgressBar").value = 0
	while i != 0:
		var bullet_instance = bullet.instance()
		bullet_instance.position = end_of_gun.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		yield(get_tree().create_timer(fire_rate - 0.45), "timeout")
		magazine = magazine - 1
		stats.bullet = magazine
		$Shot.play()
		i -= 1

func bleed_attack():
	get_node("PowerBar/Skill2CDBar/RightBR_1").visible = false
	if get_node("PowerBar/Skill2CDBar/CDProgressBar").value > 0:
		get_node("PowerBar/Skill2CDBar/CDProgressBar").value = 0
	var bullet_instance = bullet.instance()
	bullet_instance.position = end_of_gun.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	bullet_instance.scale.x = 10
	bullet_instance.scale.y = 10
	get_tree().get_root().add_child(bullet_instance)

	magazine = magazine - 1
	stats.bullet = magazine
	$Shot.play()
	

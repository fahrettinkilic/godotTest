extends "res://Player/Player.gd"

const Cooldown = preload("res://Frostmage/Cooldowns.gd")

onready var shadowbolt = preload("res://Warlock/Shadowtbolt.tscn")
onready var demon = preload("res://Practice/Enemy.tscn")
onready var skill2_cd = Cooldown.new(10)
onready var skill1_cd = Cooldown.new(10)
onready var blink_cd = Cooldown.new(10)

export var demon_start = 1
export var demon_end = 61
export var blink_range = 300
export var shadowbolt_speed = 500
export var demon_range = Vector2(300, 300)

func _ready():
	pass
	print("warlock")

func _physics_process(delta):
	skill2_cd.tick(delta)
	skill1_cd.tick(delta)
	blink_cd.tick(delta)
	
	if Input.is_action_just_pressed("blink") and blink_cd.is_ready():
		blink()
	if Input.is_action_just_pressed("skill1") and skill1_cd.is_ready():
		shadowbolt()
	if Input.is_action_just_pressed("skill2") and skill2_cd.is_ready():
		summon_demon()

func blink():
	get_node("PowerBar/BlinkCDBar/RightBR_1").visible = false
	if get_node("PowerBar/BlinkCDBar/CDProgressBar").value > 0:
		get_node("PowerBar/BlinkCDBar/CDProgressBar").value = 0
	var blink_direction = (get_global_mouse_position() - self.position).normalized()
	self.position = self.position + blink_direction * blink_range 

func shadowbolt():
	get_node("PowerBar/Skill1CDBar/RightBR_1").visible = false
	if get_node("PowerBar/Skill1CDBar/CDProgressBar").value > 0:
		get_node("PowerBar/Skill1CDBar/CDProgressBar").value = 0
	var shadowbolt_instance = shadowbolt.instance()
	shadowbolt_instance.position = end_of_gun.get_global_position()
	shadowbolt_instance.rotation_degrees = rotation_degrees
	shadowbolt_instance.apply_impulse(Vector2(), Vector2(shadowbolt_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(shadowbolt_instance)
	
func summon_demon():
	get_node("PowerBar/Skill2CDBar/RightBR_1").visible = false
	if get_node("PowerBar/Skill2CDBar/CDProgressBar").value > 0:
		get_node("PowerBar/Skill2CDBar/CDProgressBar").value = 0
	if ((get_global_mouse_position() - self.position).length() <= (demon_range.length())/sqrt(2)):
		var demon_instance = demon.instance()
		demon_instance.position = get_global_mouse_position()
		yield(get_tree().create_timer(demon_start), "timeout")
		get_tree().get_root().add_child(demon_instance)
		yield(get_tree().create_timer(demon_end), "timeout")
		demon_instance.queue_free()
		print("inrange")
	else: 
		print("outofrange")
		var demon_instance = demon.instance()
		var direction = (get_global_mouse_position() - self.position).normalized()
		demon_instance.position = self.position + (demon_range * direction)
		yield(get_tree().create_timer(demon_start), "timeout")
		get_tree().get_root().add_child(demon_instance)
		yield(get_tree().create_timer(demon_end), "timeout")
		demon_instance.queue_free()
	

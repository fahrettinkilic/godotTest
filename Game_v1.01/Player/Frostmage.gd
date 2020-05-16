extends "res://Player/Player.gd"

const Cooldown = preload("res://Frostmage/Cooldowns.gd")

export var blizzard_start = 0.5
export var blizzard_end = 5.5
export var blizzard_range = Vector2(500, 500)
export var frostbolt_speed = 500
export var blink_range = 300

var frostbolt = preload("res://Frostmage/Frostbolt.tscn")
var blizzard = preload("res://Frostmage/Blizzard.tscn")
var blizzard_pos = Vector2.ZERO

onready var blizzard_cooldown = get_node("PowerBar/BlizzardCDBar")
onready var blizzard_cd = Cooldown.new(10)
onready var frostbolt_cd = Cooldown.new(10)
onready var blink_cd = Cooldown.new(10)

func _physics_process(delta):
	blizzard_cd.tick(delta)
	frostbolt_cd.tick(delta)
	blink_cd.tick(delta)

	if Input.is_action_just_pressed("skill1") and blizzard_cd.is_ready():
		blizzard_on()
	if Input.is_action_just_pressed("skill2") and frostbolt_cd.is_ready():
		frostbolt()
	if Input.is_action_just_pressed("blink") and blink_cd.is_ready():
		blink()

func blink():
	get_node("PowerBar/BlinkCDBar/RightBR_1").visible = false
	if get_node("PowerBar/BlinkCDBar/CDProgressBar").value > 0:
		get_node("PowerBar/BlinkCDBar/CDProgressBar").value = 0
	var blink_direction = (get_global_mouse_position() - self.position).normalized()
	self.position = self.position + blink_direction * blink_range 
	
func blizzard_on():
	get_node("PowerBar/Skill1CDBar/RightBR_1").visible = false
	if get_node("PowerBar/Skill1CDBar/CDProgressBar").value > 0:
		get_node("PowerBar/Skill1CDBar/CDProgressBar").value = 0
	if ((get_global_mouse_position() - self.position).length() <= (blizzard_range.length())/sqrt(2)):
		var blizzard_instance = blizzard.instance()
		blizzard_instance.position = get_global_mouse_position()
		yield(get_tree().create_timer(blizzard_start), "timeout")
		get_tree().get_root().add_child(blizzard_instance)
		yield(get_tree().create_timer(blizzard_end), "timeout")
		blizzard_instance.queue_free()
		print("inrange")
	else: 
		print("outofrange")
		var blizzard_instance = blizzard.instance()
		var direction = (get_global_mouse_position() - self.position).normalized()
		blizzard_instance.position = self.position + (blizzard_range * direction)
		yield(get_tree().create_timer(blizzard_start), "timeout")
		get_tree().get_root().add_child(blizzard_instance)
		yield(get_tree().create_timer(blizzard_end), "timeout")
		blizzard_instance.queue_free()

func frostbolt():
	get_node("PowerBar/Skill2CDBar/RightBR_1").visible = false
	if get_node("PowerBar/Skill2CDBar/CDProgressBar").value > 0:
		get_node("PowerBar/Skill2CDBar/CDProgressBar").value = 0
	var frostbolt_instance = frostbolt.instance()
	frostbolt_instance.position = end_of_gun.get_global_position()
	frostbolt_instance.rotation_degrees = rotation_degrees
	frostbolt_instance.apply_impulse(Vector2(), Vector2(frostbolt_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(frostbolt_instance)

func ready():
	pass


#func _on_CDProgressBar_value_changed(value):
##	get_node("PowerBar/CooldownBar/Timer").start()
##	get_node("PowerBar/CooldownBar/CDProgressBar").value -= 1
##	yield(get_tree().create_timer(blizzard_start), "timeout")
#	pass

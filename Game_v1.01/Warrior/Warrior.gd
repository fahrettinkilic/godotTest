extends "res://Player/Player.gd"

const Cooldown = preload("res://Frostmage/Cooldowns.gd")

onready var skill2_cd = Cooldown.new(10)
onready var skill1_cd = Cooldown.new(10)
onready var blink_cd = Cooldown.new(10)

func _ready():
	pass # Replace with function body.
	print("warrior")

func _physics_process(delta):
	skill2_cd.tick(delta)
	skill1_cd.tick(delta)
	blink_cd.tick(delta)

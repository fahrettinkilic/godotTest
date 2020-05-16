extends Control

var health = 10 setget set_health
var max_health = 10 setget set_max_health

onready var healthFull = $HealthFull
onready var healthEmpty = $HealthEmpty

func set_health(value):
	health = clamp(value, 0, max_health)
	if healthFull != null:
		healthFull.rect_size.x = health * 64
		
func set_max_health(value):
	max_health = max(value, 10)
	self.health = min(health, max_health)
	if healthFull != null:
		healthFull.rect_size.x = health * 64
		
func _ready():
	self.health = PlayerStats.health
	self.max_health = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_health")
	PlayerStats.connect("max_health_changed", self, "set_max_health")

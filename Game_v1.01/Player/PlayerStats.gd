extends Node

export(int) var max_bullet = 1 setget set_max_bullet
var bullet = max_bullet setget set_bullet
export(int) var max_health = 10 setget set_max_health
var health = max_health setget set_health
var damage = 3

signal health_changed(value)
signal max_health_changed(value)
signal bullet_changed(value)
signal max_bullet_changed(value)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	
func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_max_bullet(value):
	max_bullet = value
	self.bullet = min(bullet, max_bullet)
	emit_signal("max_bullet_changed", max_bullet)

func set_bullet(value):
	bullet = value
	emit_signal("bullet_changed", bullet)

func _ready():
	self.bullet = max_bullet
	self.health = max_health

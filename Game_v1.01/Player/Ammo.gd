extends Control

var bullet = 10 setget set_bullet
var max_bullet = 10 setget set_max_bullet

onready var ammoFull = $AmmoFull
onready var ammoEmpty = $AmmoEmpty

func set_bullet(value):
	bullet = clamp(value, 0, max_bullet)
	if ammoFull != null:
		ammoFull.rect_size.x = bullet * 17.1
		
func set_max_bullet(value):
	max_bullet = max(value, 10)
	self.bullet = min(bullet, max_bullet)
	if ammoFull != null:
		ammoFull.rect_size.x = bullet * 17.1
		
func _ready():
	self.bullet = PlayerStats.bullet
	self.max_bullet = PlayerStats.bullet
	PlayerStats.connect("bullet_changed", self, "set_bullet")
	PlayerStats.connect("max_bullet_changed", self, "set_max_bullet")

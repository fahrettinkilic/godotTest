extends Node2D

var character = 0 setget set_character
	
signal selected_character()

func _ready():
	self.character = character

#	get_tree().change_scene("res://Practice/Practice.tscn")

func set_character(value):
	character = value
	emit_signal("selected_character", character)

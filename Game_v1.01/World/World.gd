extends Node2D

var can_start = true
var can_finish = true
var can_practice = true

func _physics_process(delta):
	pass

func _ready():
	pass

func _on_Finish_pressed():
	get_tree().quit()
	
func _on_Practice_pressed():
	get_tree().change_scene("res://Practice/Practice.tscn")
	
func _on_Start_pressed():
	get_tree().change_scene("res://Start.tscn")

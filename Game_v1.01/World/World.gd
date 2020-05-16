extends Node2D
var variable = 0
func _physics_process(delta):
	pass

func _ready():
	pass

func _on_Finish_pressed():
	get_tree().quit()
	
func _on_Practice_pressed():
	get_tree().change_scene("res://World/CharacterSelect.tscn")
	
func _on_Start_pressed():
	get_tree().change_scene("res://World/CharacterSelect.tscn")

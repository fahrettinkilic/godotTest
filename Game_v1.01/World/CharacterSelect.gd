extends Node2D

#signal frostmage_selected()
#signal warrior_selected()
#signal rogue_selected()
#signal warlock_selected()
#var selected_character = 0 setget set_selected_character
#var frostmage
#var warlock
#var rogue
#var warrior
#
#func _physics_process(delta):
#	if 

func _on_Frostmage_pressed():
	GlobalCharacterSelect.character = 1
	print(GlobalCharacterSelect.character)
	practice_scene()
	
func _on_Warlock_pressed():
	GlobalCharacterSelect.character = 2
	print(GlobalCharacterSelect.character)
	practice_scene()
func _on_Rogue_pressed():
	GlobalCharacterSelect.character = 3
	print(GlobalCharacterSelect.character)
	practice_scene()
func _on_Warrior_pressed():
	GlobalCharacterSelect.character = 4
	print(GlobalCharacterSelect.character)
	practice_scene()

func practice_scene():
	get_tree().change_scene("res://Practice/Practice.tscn")

func selected_character():
	pass

func _ready():
	pass
#	self.player = GlobalCharacterSelect.character
#	GlobalCharacterSelect.connect("selected_character", self, "character_set")

#func frostmage_selected():
#	pass
#func warrior_selected():
#	pass
#func rogue_selected():
#	pass
#func warlock_selected():
#	pass
#
#func set_character():
#	emit_signal("character")
#



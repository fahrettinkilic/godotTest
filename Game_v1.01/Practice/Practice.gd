#extends Node2D
extends "res://World/CharacterSelect.gd"

var enemy = preload("res://Practice/Enemy.tscn")
var character = 0 setget set_character
var origin = Vector2.ZERO
var frostmage = preload("res://Player/Frostmage.tscn")
var warlock = preload("res://Warlock/Warlock.tscn")
var warrior = preload("res://Warrior/Warrior.tscn")
var rogue = preload("res://Rogue/Rogue.tscn")
var canselect = true

func character_select():
	if GlobalCharacterSelect.character == 1 and canselect == true:
		print("frostmage")
		var frostmage_instance = frostmage.instance()
		get_tree().get_root().add_child(frostmage_instance)
		canselect = false
	if GlobalCharacterSelect.character == 2 and canselect == true:
		var selectedcharacter = preload("res://Warlock/Warlock.tscn")
		print("warlock")
		var warlock_instance = warlock.instance()
		get_tree().get_root().add_child(warlock_instance)
		canselect = false
	if GlobalCharacterSelect.character == 3 and canselect == true:
		var selectedcharacter = preload("res://Rogue/Rogue.tscn")
		print("rogue")
		var rogue_instance = rogue.instance()
		canselect = false
		get_tree().get_root().add_child(rogue_instance)
	if GlobalCharacterSelect.character == 4 and canselect == true:
		var selectedcharacter = preload("res://Warrior/Warrior.tscn")
		print("warrior")
		var warrior_instance = warrior.instance()
		canselect = false
		get_tree().get_root().add_child(warrior_instance)
		
func set_character(value):
	character = GlobalCharacterSelect.character

func _physics_process(delta):
#	GlobalCharacterSelect.connect("selected_character", self, "set_character")
	print(GlobalCharacterSelect.character)
	character_select()

func _ready():
	pass
	
func _on_respawnTimer_timeout():
	var yLoc = rand_range(1080, 0)
	var xLoc = rand_range(0, 1920)
	var e = enemy.instance()
	add_child(e)
	e.position = Vector2(xLoc, yLoc)
	$respawnTimer.wait_time = max(0.5, $respawnTimer.wait_time - 0.05)

func _on_Enemy_tree_exiting():
	enemy_killed()
	
func enemy_killed():
	var score = 0
	score = score + 1
	print(score)
	


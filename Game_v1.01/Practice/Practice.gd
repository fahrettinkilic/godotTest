extends Node2D

var enemy = preload("res://Practice/Enemy.tscn")
var player = preload("res://Player/Frostmage.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		player = player.instance()
		add_child(player)
		player.position = get_global_mouse_position()

func _ready():
	pass # Replace with function body.

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
	


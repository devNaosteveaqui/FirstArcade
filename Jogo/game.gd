extends Node2D

enum SPAWN{ALAN,BONBON,LIPS}

var right_pos = 1120
var spawn_delay = 1

func _ready():
	$Timer.connect("timeout",sort_spawn)
	$Timer.start(spawn_delay)

func spawn(resource):
	var enemy = load(resource).instantiate()
	enemy.position.x = right_pos
	enemy.position.y = sort_next_position()
	enemy.connect("die",$UI/Info/Score.add_score)
	add_child(enemy)

func sort_spawn():
	var sorted = randi()%SPAWN.size()
	
	match sorted:
		SPAWN.ALAN:
			spawn("res://alan.tscn")
		SPAWN.BONBON:
			spawn("res://bonbon.tscn")
		SPAWN.LIPS:
			spawn("res://lips.tscn")

func sort_next_position():
	var nextp = get_window().size.y*0.75 - randi()%320
	return nextp


func _on_life_lose_game():
	$"UI/Game Over".show()
	get_tree().paused = true

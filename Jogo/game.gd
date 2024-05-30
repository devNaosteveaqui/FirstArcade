extends Node2D

enum SPAWN{ALAN,BONBON,LIPS}

var right_pos
var spawn_delay = 1
var box_count = 0

func _ready():
	right_pos = get_viewport_rect().size.x
	$Timer.connect("timeout",sort_spawn)
	$Timer.start(spawn_delay)
	$"UI/Start Game".show()
	get_tree().paused = true
	$Entitys/player.position.x = 32
	$Entitys/player.position.y = get_viewport_rect().size.y/2

func spawn(resource):
	var enemy = load(resource).instantiate()
	enemy.position.x = right_pos
	enemy.position.y = sort_next_position()
	if enemy.has_signal("die"):
		enemy.connect("die",$UI/Info/Score.add_score)
	$Entitys.add_child(enemy)

func sort_spawn():
	var score = $UI/Info/Score.get_score()
	
	if box_count < int(score/50):
		box_count = int(score/50)
		spawn("res://box.tscn")
	else:
		var sorted = randi()%SPAWN.size()
		match sorted:
			SPAWN.ALAN:
				spawn("res://alan.tscn")
			SPAWN.BONBON:
				spawn("res://bonbon.tscn")
			SPAWN.LIPS:
				spawn("res://lips.tscn")

func sort_next_position():
	var nextp = get_viewport_rect().size.y*0.75 - randi()%(int(get_viewport_rect().size.y/2))
	return nextp


func _on_life_lose_game():
	$"UI/End Game".show()
	get_tree().paused = true


func _on_texture_button_button_up():
	if $"UI/Start Game".is_visible_in_tree():
		$"UI/Start Game".hide()
		$UI/StartGameClick.play()
	if get_tree().paused:
		get_tree().paused = false
	if $"UI/End Game".is_visible_in_tree():
		$UI/EndGameClick.play()
		await $UI/EndGameClick.finished
		get_tree().reload_current_scene()

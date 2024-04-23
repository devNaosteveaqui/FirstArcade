extends CharacterBody2D

signal recive_damage
signal shot

const speed_magnitude : int = 100
const power_max : int = 10

@export var power_interface : Node

var speed = 4
var timer_recovery = 0.2
var can_fire : bool = false

func _ready():
	add_to_group("Player")
	$Booster.play("default")
	$Timer.start(timer_recovery)
	$Timer.connect("timeout",update_power)

func update_power():
	power_interface.update_power()
	can_fire = power_interface.is_power_max(power_max)
		

func _physics_process(delta):
	var vel = speed_magnitude
	if Input.is_action_pressed("move_up"):
		velocity.y = -vel
		$Booster.play("left")
	elif Input.is_action_pressed("move_down"):
		velocity.y = vel
		$Booster.play("right")
	else:
		velocity.y = 0
		$Booster.play("default")
	
	if Input.is_action_just_pressed("fire"):
		if can_fire:
			var projetil = load("res://projetil_normal.tscn").instantiate()
			projetil.position = Vector2(position.x + 16, position.y)
			get_parent().add_child(projetil)
			
			power_interface.use_power()
	
	var collide = move_and_collide(velocity*delta)
	
	if velocity.y < 0:
		$ship.frame = 0
	elif velocity.y > 0:
		$ship.frame = 2
	else:
		$ship.frame = 1
	

func collision(collide):
	if collide.is_in_group("Enemy"):
		self.emit_signal("recive_damage")
	else:
		print(collide)

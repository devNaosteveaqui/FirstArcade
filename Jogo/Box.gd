extends CharacterBody2D

func _ready():
	add_to_group("RandomAmmo")
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	if position.x < 0:
		self.queue_free()
	velocity = Vector2(-100,0)
	move_and_slide()
	var collide = get_last_slide_collision()
	if collide:
		if collide.get_collider().has_method("collision"):
			collide.get_collider().collision(self)
			self.queue_free()

func random_ammo():
	var ammo_sorted = randi()%Shot.TYPE_SPECIAL_SHOOT_BASE.size()
	return ammo_sorted

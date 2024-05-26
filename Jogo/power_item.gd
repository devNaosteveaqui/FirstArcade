extends CharacterBody2D

func _ready():
	add_to_group("PowerUP")
	$Item.play("default")
	$Sparkle.play("default")

func _physics_process(delta):
	velocity = Vector2(-100,0)
	move_and_slide()
	var collide = get_last_slide_collision()
	if collide:
		if collide.get_collider().has_method("collision"):
			collide.get_collider().collision(self)
			self.queue_free()

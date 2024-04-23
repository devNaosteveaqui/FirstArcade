extends CharacterBody2D

signal die

var speed : Vector2 = Vector2(-100,0)
var alive : bool = true

func _ready():
	$AnimatedSprite2D.play("default")
	add_to_group("Enemy")

func _physics_process(delta):
	if alive:
		self.velocity = speed
		move_and_slide()
		var collide = get_last_slide_collision()
		if collide:
			if collide.get_collider().has_method("collision"):
				collide.get_collider().collision(self)
			else:
				collide.get_collider().queue_free()
			alive = false
			set_collision_layer_value(1,false)
			$AnimatedSprite2D.play("die")
			emit_signal("die")


func _on_animated_sprite_2d_animation_looped():
	if not alive:
		self.queue_free()

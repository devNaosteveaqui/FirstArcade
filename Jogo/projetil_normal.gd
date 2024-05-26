extends CharacterBody2D

class_name Shot

enum TYPE_SPECIAL_SHOOT_BASE {DONUT,SQUARE,MISSEL}
enum TYPE_SHOT {NORMAL,CHARGED,DONUT,SQUARE,DONUT_CHARGED,SQUARE_CHARGED,MISSEL}

var charged : bool = false
var type_shot : TYPE_SHOT
var player : CharacterBody2D
var speed = 150
var target

func _physics_process(delta):
	if position.x < 0:
		self.queue_free()
	
	if type_shot == TYPE_SHOT.MISSEL:
		velocity = Vector2(speed,speed)
		if target == null:
			target = find_enemy_nearest()
		var direction
		if target != null:
			direction = self.position.direction_to(target.position)
			if direction.x > 0:
				if direction.y > 0:
					$Missel.play("frente_direita")
				elif direction.y < 0:
					$Missel.play("atras_direita")
				else:
					$Missel.play("direita")
			elif direction.x < 0:
				if direction.y > 0:
					$Missel.play("frente_esquerda")
				elif direction.y < 0:
					$Missel.play("atras_esquerda")
				else:
					$Missel.play("esquerda")
			else:
				if direction.y > 0:
					$Missel.play("default")
				elif direction.y < 0:
					$Missel.play("atras")
		else:
			direction = Vector2(1,0)
			$Missel.play("default")
		velocity = speed*direction
	else:
		velocity = Vector2(speed,0)
	move_and_slide()

func find_enemy_nearest():
	var obj = $detect.get_overlapping_bodies()
	var tgt
	for o in obj:
		if o.is_in_group("Enemy"):
			var max_ob
			var dist = self.position.distance_to(o.position)
			var angle = self.position.angle_to(o.position)
			var ob = {'dist':dist,'angle':angle,'obj':o}
			if max_ob == null:
				max_ob = ob.duplicate(true)
				tgt = ob.obj
			else:
				if max_ob.angle < ob.angle and max_ob.dist > ob.dist:
					max_ob = ob
					tgt = ob.obj
	return tgt
func set_shoot_type(type:TYPE_SPECIAL_SHOOT_BASE):
	match type:
		Shot.TYPE_SPECIAL_SHOOT_BASE.DONUT:
			return Shot.TYPE_SHOT.DONUT
		Shot.TYPE_SPECIAL_SHOOT_BASE.SQUARE:
			return Shot.TYPE_SHOT.SQUARE
		Shot.TYPE_SPECIAL_SHOOT_BASE.MISSEL:
			return Shot.TYPE_SHOT.MISSEL
		_:
			return Shot.TYPE_SHOT.NORMAL

func set_animation(charged:bool,type:TYPE_SPECIAL_SHOOT_BASE):
	var type_s = set_shoot_type(type)
	if charged:
		type_shot = set_charged_version(type_s)
		speed = speed*2
	else:
		type_shot = type_s
	
	$Normal.hide()
	$Charged.hide()
	$Donut.hide()
	$Square.hide()
	$"Donut Charged".hide()
	$"Square Charged".hide()
	$Missel.hide()
	match type_shot:
		TYPE_SHOT.NORMAL:
			active_animation($Normal)
		TYPE_SHOT.CHARGED:
			active_animation($Charged)
		TYPE_SHOT.DONUT:
			active_animation($Donut)
		TYPE_SHOT.DONUT_CHARGED:
			active_animation($"Donut Charged")
		TYPE_SHOT.SQUARE:
			active_animation($Square)
		TYPE_SHOT.SQUARE_CHARGED:
			active_animation($"Square Charged")
		TYPE_SHOT.MISSEL:
			active_animation($Missel)

func active_animation(node:AnimatedSprite2D):
	node.show()
	node.play("default")
	node.rotate(PI/2)

func set_charged_version(type:Shot.TYPE_SHOT):
	match type:
		TYPE_SHOT.NORMAL:
			return TYPE_SHOT.CHARGED
		TYPE_SHOT.DONUT:
			return TYPE_SHOT.DONUT_CHARGED
		TYPE_SHOT.SQUARE:
			return TYPE_SHOT.SQUARE_CHARGED
		_:
			return type

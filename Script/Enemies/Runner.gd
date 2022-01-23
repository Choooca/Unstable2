extends KinematicBody2D
var speed = 300
var velocity = Vector2.ZERO
var direction
var damage = 1
var health = 3

func _ready():
	direction = Vector2(randi()%10 - 5, randi()%10 - 5).normalized()

func _physics_process(delta):
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision:
		if collision.get_collider().name == "Player":
			if collision.get_collider().damage == 0:
				collision.get_collider().take_damage(damage)
		if is_on_ceiling() or is_on_floor():
			direction.y = - direction.y
		elif is_on_wall():
			direction.x = -direction.x
		else:
			direction = direction.rotated(180 + rand_range(-45 , 45))

func take_damage(damage):
	health -= damage
	if health <= 0:
		get_parent().get_parent().Kill()
		queue_free()
	else:
		pass

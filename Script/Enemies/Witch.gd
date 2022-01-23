extends KinematicBody2D
onready var Player = get_tree().get_root().get_node("Main/Player")
onready var WitchEffect = get_tree().get_root().get_node("Main/Player/Sprites/WitchEffect")
var speed = 3000
var velocity = Vector2.ZERO
var health = 2
var direction
var attack

func _ready():
	randomize()
	direction = Vector2((randi()% 10) - 5, (randi()%10) - 5).normalized()
	$Timer.wait_time = 1 + (randf())
	$Timer.start()
	$AttackStart.wait_time = 1
	$AttackStart.start()
	

func _physics_process(delta):
	if attack == true and global_position.distance_to(Player.global_position) < 500:
		Player.distance = -Player.distance
		WitchEffect.visible = true
	else:
		WitchEffect.visible = false
	if $AnimatedSprite.animation !="hit":
		velocity = speed * direction * delta
		var collision = move_and_collide(velocity * delta)
		if collision:
			if is_on_wall():
				direction.x = -direction.x
			elif is_on_floor() or is_on_ceiling():
				direction.y = -direction.y
			else:
				direction = -direction


func _on_Timer_timeout():
	direction = direction.rotated(rand_range(-rad2deg(30), rad2deg(30)))
	$Timer.wait_time = 1 + (randf())
	$Timer.start()


func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		velocity += body.velocity
		
func take_damage(damage):
	health -= damage
	if health <= 0:
		attack = false
		get_parent().get_parent().Kill()
		queue_free()
	else:
		pass


func _on_AttackStart_timeout():
	$AnimatedSprite.animation = "hit"
	var Anim = Timer.new()
	add_child(Anim)
	Anim.wait_time = 2
	Anim.start()
	yield(Anim, "timeout")
	Anim.queue_free()
	attack = true
	$AnimatedSprite.animation = 'Run'
	$AttackStop.wait_time = 4
	$AttackStop.start()

func _on_AttackStop_timeout():
	attack = false
	$AttackStart.wait_time = 5
	$AttackStart.start()

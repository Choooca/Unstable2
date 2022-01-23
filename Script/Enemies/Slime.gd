extends KinematicBody2D
onready var Player = get_tree().get_root().get_node("Main/Player")
onready var Tacheasset = preload("res://Scene/Enemies/Tache.tscn")
var speed = 4000
var velocity = Vector2.ZERO
var Tachetab = [0,0,0,0,0,0,0]
var direction
var health = 1

func take_damage(damage):
	health -= damage
	if health <= 0:
		get_parent().get_parent().get_parent().Kill()
		get_parent().queue_free()
	else:
		pass
		
func _ready():
	randomize()
	direction = Vector2((randi()% 10) - 5, (randi()%10) - 5).normalized()
	$Timer.wait_time = .75 + ((randf())+ (randf()/2))
	$Timer.start()
	$TimerTache.wait_time = .1
	$TimerTache.start()

func _physics_process(delta):
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
	direction = direction.rotated(rand_range(-rad2deg(.2), rad2deg(.2)))
	$Timer.wait_time = .2 + (randf()+ randf()/2)
	$Timer.start()

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		velocity += body.velocity


func _on_TimerTache_timeout():
	if Tachetab[6] is Node2D:
		Tachetab[6].queue_free()
	Tachetab[6] = Tachetab[5]
	Tachetab[5] = Tachetab[4]
	Tachetab[4] = Tachetab[3]
	Tachetab[3] = Tachetab[2]
	Tachetab[2] = Tachetab[1]
	Tachetab[1] = Tachetab[0]
	Tachetab[0] = Tacheasset.instance()
	Tachetab[0].global_position = position
	get_parent().add_child(Tachetab[0])
	$TimerTache.wait_time = .4
	$TimerTache.start()

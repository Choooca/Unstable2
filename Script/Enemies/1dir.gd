extends RigidBody2D
onready var preproj = preload("res://Scene/Enemies/Projectile.tscn")
onready var Player = get_tree().get_root().get_node("Main/Player")
var direction = Vector2.ZERO
var proj
var pos
var spawn
var health = 1

func _ready():
	$Timer.wait_time = 2
	$Timer.start()

func _physics_process(delta):
	$AnimatedSprite.rotation = global_position.angle_to_point(Player.global_position)


func _on_Timer_timeout():
	for i in 3:
		proj = preproj.instance()
		add_child(proj)
		proj.position = $AnimatedSprite/Position2D.position
		proj.direction = proj.global_position.direction_to(Player.global_position)
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 0.1
		timer.start()
		yield(timer , "timeout")
		timer.queue_free()
		
func take_damage(damage):
	health -= damage
	if health <= 0:
		get_parent().get_parent().Kill()
		queue_free()
	else:
		pass

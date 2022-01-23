extends KinematicBody2D
onready var Player = get_tree().get_root().get_node("Main/Player")
var speed = 2000
var velocity = Vector2.ZERO
var direction
var damage = 2
var attack = 2
var health = 5

func _ready():
	$Charge.wait_time = 3
	$Charge.start()

func _physics_process(delta):
	var las_pos = position
	velocity *= 0.9
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.get_collider().name == "Player":
				if collision.get_collider().damage == 0:
					collision.get_collider().take_damage(damage)
					velocity = Vector2.ZERO
	if las_pos == position and $Charge.is_stopped():
		$Charge.wait_time = 1.5
		$Charge.start()

func _on_Charge_timeout():
	direction = global_position.direction_to(Player.position)
	velocity = direction * speed

func take_damage(damage):
	health -= damage
	if health <= 0:
		get_parent().get_parent().Kill()
		get_parent().queue_free()
	else:
		pass

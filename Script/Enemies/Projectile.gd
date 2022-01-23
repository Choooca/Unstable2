extends KinematicBody2D
var direction = Vector2.ZERO
var damage = 1
var speed = 20000
var velocity = Vector2.ZERO

func _ready():
	$Timer.wait_time = 1
	$Timer.start()
	
func _physics_process(delta):
	velocity= direction * speed * delta
	velocity = move_and_slide(velocity)

	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Timer_timeout():
	queue_free()

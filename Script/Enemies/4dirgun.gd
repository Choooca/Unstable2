extends StaticBody2D
onready var Beams = [$RayCast2DE, $RayCast2DN, $RayCast2DS, $RayCast2DW]
var rand
var health = 3
func _ready():
	randomize()
	rand = 1 + (randf() * 2)
	$TimerStart.set_wait_time(rand)
	$TimerStart.start(rand)
	$TimerAnim.set_wait_time(rand - .5)
	$TimerAnim.start()

func _on_TimerStart_timeout():
	for i in len(Beams):
		Beams[i].is_casting = true
	$TimerStop.set_wait_time(1)
	$TimerStop.start()
	$AnimatedSprite.playing = false


func _on_TimerStop_timeout():
	for i in len(Beams):
		Beams[i].is_casting = false
	rand = 2 + randi()%2
	$TimerStart.set_wait_time(rand)
	$TimerStart.start()
	$TimerAnim.set_wait_time(rand - .5)
	$TimerAnim.start()

func _on_TimerAnim_timeout():
	$AnimatedSprite.playing = true 

func take_damage(damage):
	health -= damage
	if health <= 0:
		get_parent().get_parent().Kill()
		queue_free()
	else:
		pass

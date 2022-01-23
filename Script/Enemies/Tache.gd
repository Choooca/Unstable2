extends Node2D
var damage = .5


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)

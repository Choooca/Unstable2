extends Node2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
			get_node("/root/Main").Change_room(Vector2(1,0))

extends Node2D

func _on_Door_up_open_body_entered(body):
	if body.name == "Player":
		get_node("/root/Main").Change_room(Vector2(0,-1))

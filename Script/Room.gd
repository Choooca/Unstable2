extends Node2D
class_name Rooms
onready var fight = true
onready var cell_dir = get_tree().get_root().get_node("Main").cell_dir
var Enemies
var value

func _ready():
	var room = $Room
	Enemies = $Enemies.get_child_count()
	for child in $Enemies.get_children():
		child.set_physics_process(false)
	$Room.connect("body_entered", self, "Enter")

func Enter(body):
	if body.name == "Player":
		for child in $Enemies.get_children(): 
			child.set_physics_process(true)

func Kill():
	Enemies -= 1
	if Enemies == 0:
		fight = false
		get_parent().reset_door(value)
		get_parent().make_door(value, cell_dir)

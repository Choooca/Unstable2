extends Node2D
onready var img = preload("res://Scene/Cell.tscn")
var cell_pos = []
var cell_matrice = []
var max_room = 15
var min_room = 10
var cell_size = Vector2(24,16)
var min_pos = Vector2(INF, INF)
var max_pos = Vector2(0, 0)
var full_rect = Rect2()
var pos
var next_cell
var cell

func _ready():
	randomize()
	cell = img.instance()
	add_child(cell)
	cell.position = Vector2(0,0)
	cell_pos.append(cell.position)
	make_room()

func make_room():
	for i in (min_room + (randi() %(max_room - min_room))):
		var current_cell = has_neighbour()
		next_cell = randi() % 4
		if next_cell == 0 and not cell_pos.has(cell_pos[current_cell] + Vector2(0, -16)):
			cell = img.instance()
			add_child(cell)
			cell.position = cell_pos[current_cell] + Vector2(0, -16)
			cell_pos.append(cell.position)	
		elif cell_pos.has(cell_pos[current_cell] + Vector2(0, -16)):
			next_cell = (randi() % 3) + 1
		if next_cell == 1 and not cell_pos.has(cell_pos[current_cell] + Vector2(24, 0)):
			cell = img.instance()
			add_child(cell)
			cell.position = cell_pos[current_cell] + Vector2(24, 0)
			cell_pos.append(cell.position)
		elif cell_pos.has(cell_pos[current_cell] + Vector2(24, 0)):
			next_cell = (randi() % 2) + 2
		if next_cell == 2 and not cell_pos.has(cell_pos[current_cell] + Vector2(0, 16)):
			cell = img.instance()
			add_child(cell)
			cell.position = cell_pos[current_cell] + Vector2(0, 16)
			cell_pos.append(cell.position)
		elif cell_pos.has(cell_pos[current_cell] + Vector2(0, 16)):
			next_cell = 3
		if next_cell == 3 and not cell_pos.has(cell_pos[current_cell] + Vector2(-24, 0)):
			cell = img.instance()
			add_child(cell)
			cell.position = cell_pos[current_cell] + Vector2(-24, 0)
			cell_pos.append(cell.position)
	for room in len(cell_pos):
		cell_matrice.append(Vector2((cell_pos[room].x) / 24, (cell_pos[room].y ) / 16))
	
func has_neighbour():
	var current_cell = randi() % len(cell_pos)
	if cell_pos.has(cell_pos[current_cell] + Vector2(0, 16)) and cell_pos.has(cell_pos[current_cell]+ Vector2(0, -16)) and cell_pos.has(cell_pos[current_cell]+ Vector2(24, 0)) and cell_pos.has(cell_pos[current_cell]+ Vector2(-24, 0)):
		return has_neighbour()
	else:
		return current_cell

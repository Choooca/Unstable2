extends Node2D
onready var Room1 = preload("res://Scene/Room/Room1.tscn")
onready var Room2 = preload("res://Scene/Room/Room2.tscn")
onready var Room3 = preload("res://Scene/Room/Room3.tscn")
onready var Room4 = preload("res://Scene/Room/Room4.tscn")
onready var Room5 = preload("res://Scene/Room/Room5.tscn")
onready var RoomStart1 = preload("res://Scene/Room/RoomStart1.tscn")
onready var RoomStart2 = preload("res://Scene/Room/RoomStart2.tscn")
onready var Door_up = [preload("res://Scene/Door/Door_up/Door_up_close.tscn"), preload("res://Scene/Door/Door_up/Door_up_open.tscn")]
onready var Door_down = [preload("res://Scene/Door/Door_down/Door_down_close.tscn"), preload("res://Scene/Door/Door_down/Door_down_open.tscn")]
onready var Door_left = [preload("res://Scene/Door/Door_left/Door_left_close.tscn"), preload("res://Scene/Door/Door_left/Door_left_open.tscn")]
onready var Door_right = [preload("res://Scene/Door/Door_right/Door_right_close.tscn"), preload("res://Scene/Door/Door_right/Door_right_open.tscn")]
onready var MapSprite = $Control/CanvasLayer/ViewportContainer/Viewport/Map/Sprite
onready var SpriteMap = $Control/CanvasLayer/ViewportContainer/Viewport/Map/Sprite
onready var cell_matrice = $Control/CanvasLayer/ViewportContainer/Viewport/Map.cell_matrice
onready var LifeBar = [$LifeBar/CanvasLayer/TextureRect, $LifeBar/CanvasLayer/TextureRect2, $LifeBar/CanvasLayer/TextureRect3, $LifeBar/CanvasLayer/TextureRect4, $LifeBar/CanvasLayer/TextureRect5]
onready var player = $Player
var current_room = Vector2()
var Rooms = []
var RoomStart = []
var cell_dir = {}
var door_dir = {}
var cell
var door

func _ready():
	$Player.position = Vector2.ZERO
	Rooms = [Room1, Room2, Room3, Room4, Room5]
	RoomStart = [RoomStart1, RoomStart2]
	current_room = Vector2(0,0)
	cell = RoomStart[randi()%2].instance()
	cell.scale = Vector2(2,2)
	cell_dir[Vector2(0,0)] = cell
	cell.position = (Vector2(0,0))
	add_child(cell)
	for room in cell_matrice:
		if room != Vector2(0,0):
			cell = Rooms[randi()%5].instance()
			cell.scale = Vector2(2,2)
			cell.position = (room * 1000)
			cell.value = room
			add_child(cell)
			cell_dir[room] = cell
		make_door(room, cell_dir)
	MapSprite.position = current_room 
	$Camera2D.position = Vector2(0,0)
	player.position = Vector2(0,0)
	player.scale = Vector2(2,2)
	
func Change_room(direction):
	current_room += direction
	$Camera2D.position = Vector2(cell_dir[current_room].position.x + (60 * direction.x),cell_dir[current_room].position.y + (48* direction.y))
	player.velocity = Vector2.ZERO
	player.position = Vector2(cell_dir[current_room].position.x - (170 * direction.x), cell_dir[current_room].position.y - (110*direction.y))
	MapSprite.position = Vector2(current_room.x*24, current_room.y*16)
	$Player/Invincibilty.wait_time = 1
	$Player/Invincibilty.start()

func make_door(room, cell_dir):
	door_dir[room] = []
	if cell_matrice.has(Vector2(room.x, room.y -1)) and cell_dir[room].fight == false:
		door = Door_up[1].instance()
		add_child(door)
		door.position = Vector2(0, -163) + cell_dir[room].position
		door_dir[room].append(door)
	else:
		door = Door_up[0].instance()
		add_child(door)
		door.position = Vector2(0, -163) + cell_dir[room].position
		door_dir[room].append(door)
	if cell_matrice.has(Vector2(room.x, room.y +1)) and cell_dir[room].fight == false:
		door = Door_down[1].instance()
		add_child(door)
		door.position = Vector2(0, 125) + cell_dir[room].position
		door_dir[room].append(door)
	else:
		door = Door_down[0].instance()
		add_child(door)
		door.position = Vector2(0, 125) + cell_dir[room].position
		door_dir[room].append(door)
	if cell_matrice.has(Vector2(room.x-1, room.y)) and cell_dir[room].fight == false:
		door = Door_left[1].instance()
		add_child(door)
		door.position = Vector2(-175, 0) + cell_dir[room].position
		door_dir[room].append(door)
	else:
		door = Door_left[0].instance()
		add_child(door)
		door.position = Vector2(-175, 0) + cell_dir[room].position
		door_dir[room].append(door)
	if cell_matrice.has(Vector2(room.x+1, room.y)) and cell_dir[room].fight == false:
		door = Door_right[1].instance()
		add_child(door)
		door.position = Vector2(175, 0) + cell_dir[room].position
		door_dir[room].append(door)
	else:
		door = Door_right[0].instance()
		add_child(door)
		door.position = Vector2(175, 0) + cell_dir[room].position
		door_dir[room].append(door)
		
func reset_door(room):
	for door in len(door_dir[room]):
		door_dir[room][door].queue_free()

func check_health(health):
	if $Player.health < 5:
		LifeBar[0].visible = false
	if $Player.health < 4:
		LifeBar[1].visible = false
	if $Player.health < 3:
		LifeBar[2].visible = false
	if $Player.health < 2:
		LifeBar[3].visible = false
	if $Player.health < 1:
		LifeBar[4].visible = false

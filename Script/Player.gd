extends KinematicBody2D
onready var sprite = $Sprites
var direction
var Sprites = []
var frame
var speed = 0
var distance
var lastdir
var count = 0
var time = 0
var move = false
var damage
var health = 5
var i = 0
var last_pos
var velocity = Vector2(0,0)
var Enemies = []

func _ready():
	randomize()
	Enemies = ["1dir","1dir2","4dirgun","Slime","Slime2","Runner","Witch","Demon"]
	Sprites = [$Sprites/Sprite1,$Sprites/Sprite2,$Sprites/Sprite3,$Sprites/Sprite4]
	frame = 2
	speed = 50000
	last_pos = position
	Sprites[0].visible = true
	Sprites[1].visible = false
	Sprites[2].visible = false
	Sprites[3].visible = false
	$Invincibilty.stop()
	
func _physics_process(delta):
	if count == frame:
		sprite.position = Vector2(get_parent().position.x + (randi()% 2) - 0.5, get_parent().position.y + (randi()% 2) - 0.5 )
		count = 0
	else: 
		count += 1
	move(delta)
	velocity *= 0.9
	var collision = move_and_collide(velocity * delta)
	if collision:
		if Enemies.has(collision.get_collider().name):
			collision.get_collider().take_damage(damage)
			damage = 0
		velocity = velocity.bounce(collision.normal)
	if last_pos == position:
		move = false
	else:
		move = true
	if not move:
		damage = 0
	last_pos = position
	
func move(delta):
	if Input.is_action_pressed("click"):
		click()
		velocity = Vector2.ZERO
		distance = (get_global_mouse_position() - global_position).normalized()
		Sprites[0].visible = true
	else :
		if time > 20 and time < 50:
			damage = 1
		elif time >= 50 and time < 80:
			damage = 2
		elif time >= 80:
			damage = 3
		for i in range(1,len(Sprites)):
			Sprites[i].visible = false
		Sprites[0].visible = true
		if time > 0:
			velocity += distance*delta*speed
		frame = 2
		time = 0

func take_damage(attack):
	if $Invincibilty.is_stopped():
		health -= attack
		get_parent().check_health(health)
		damage_anim()
		if health <= 0:
			get_tree().reload_current_scene()
		$Invincibilty.wait_time = .9
		$Invincibilty.start()
	else :
		$Invincibilty.wait_time = .9
		$Invincibilty.start()

func damage_anim():
	$Sprites/HitDamage.visible = true
	var t = Timer.new()
	add_child(t)
	t.wait_time = .2
	t.start()
	yield(t, "timeout")
	$Sprites/HitDamage.visible = false
		
func click():
	time += 1
	if time < 20:
		speed = 80000
		frame = 2
		damage = 0
	else:
		if time > 20 and time < 50:
			frame = 2
			speed = 80000
			Sprites[0].visible = false
			Sprites[1].visible = true
		elif time > 50 and time < 80:
			frame = 1
			speed = 110000
			Sprites[1].visible = false
			Sprites[2].visible = true
		elif time > 80:
			frame = 0
			speed = 150000
			Sprites[2].visible = false
			Sprites[3].visible = true

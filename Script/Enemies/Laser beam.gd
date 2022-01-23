extends RayCast2D
var  is_casting := false setget set_is_casting
var damage = 1

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

func _physics_process(delta):
	var cast_point := cast_to
	force_raycast_update()

	if is_colliding():
		cast_point = to_local(get_collision_point())
		if get_collider().name == "Player":
			get_collider().take_damage(damage)
		
	$Line2D.points[1] = cast_point	
	
func set_is_casting(cast: bool) -> void:
	is_casting = cast

	if is_casting:
		appear()
	else:
		disappear()
	set_physics_process(is_casting)
	
func appear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D , "width" , 0.0 , 10.0 , 0.2)
	$Tween.start()
	
func disappear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D , "width" , 10.0 , 0.0 , 0.1)
	$Tween.start()
	

extends Area2D

var direction : Vector2 = Vector2(0, 0)
var velocity : float = 20.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _data_init(dmg : int, is_enemy : bool, set_global_pos : Vector2, set_velocity : float, set_direction : Vector2, rotation : int):
	set_meta("dmg", dmg)
	set_meta("is_enemy", is_enemy)
	set_rotation_degrees(rotation)
	global_position = set_global_pos
	velocity = set_velocity
	direction = set_direction
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += delta * direction.normalized() * velocity
	var rect = get_viewport_rect().grow(1.2)
	if(!rect.has_point(global_position)):
		queue_free()

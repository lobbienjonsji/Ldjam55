extends Area2D
var shot : PackedScene = preload("res://Scenes/Shot.tscn")
var current_pos :  Vector2 = Vector2(50, 50)
var current_grid_pos :  Vector2i = Vector2i(0, 0)
signal destroy(voidAt : Vector2i)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_death_timer_timeout():
	destroy.emit(current_grid_pos)
	queue_free()


func _on_shot_timer_timeout():
	for i in [
		[5, false, $ShotEmitterLeft.global_position, 300, Vector2(-1, 0), 0], 
		[5, false, $ShotEmitterTop.global_position, 300, Vector2(0, -1), 90], 
		[5, false, $ShotEmitterRight.global_position, 300, Vector2(1, 0), 180], 
		[5, false, $ShotEmitterBottom.global_position, 300, Vector2(0, 1), 270], 
		]:
		var new_shot = shot.instantiate()
		add_child(new_shot)
		new_shot._data_init(i[0],i[1],i[2],i[3],i[4],i[5])
		
func _init_position(grid_pos : Vector2i):
	current_pos = grid_pos * 100 + Vector2i(50, 50)
	global_position = current_pos
	current_grid_pos = grid_pos

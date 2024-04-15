extends Area2D
signal update_global_position(vector : Vector2)
signal update_global_grid_position(vector : Vector2)
signal recharge_player(amount : float)
var current_pos :  Vector2 = Vector2(50, 50)
var current_grid_pos :  Vector2i = Vector2i(0, 0)
var player_adjacency : Array[Vector2i] = []
var shot : PackedScene = preload("res://Scenes/Shot.tscn")
var intervall_count : int = 0
var is_shooting : bool = false
signal destroy(voidAt : Vector2i)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _init_position(grid_pos : Vector2i):
	current_pos = grid_pos * 100 + Vector2i(50, 50)
	global_position = current_pos
	current_grid_pos = grid_pos
	update_global_position.emit(current_pos)
	update_global_grid_position.emit(current_grid_pos)


func _on_timer_timeout():
	intervall_count += 1
	if(!is_shooting):
		if intervall_count >= 8 - min(Globals.Difficulty, 3):
			intervall_count = 0
			is_shooting = true
	if(is_shooting):
		is_shooting = intervall_count < 3
		var new_shot = shot.instantiate()
		add_child(new_shot)
		new_shot._data_init(5 + Globals.Difficulty, true, $ShotEmitter.global_position, 600, Vector2(-1, 0), 0)
		
func _on_health_bar_on_death():
	destroy.emit(current_grid_pos)
	Globals.MonsterCount -= 1
	Globals.Score += 1
	queue_free()


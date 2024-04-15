class_name ShootState
extends State

@export var shot_spawner : Node2D
var has_shot = false
var elasped_time : float
var shot : PackedScene = preload("res://Scenes/Shot.tscn")
var idle_time : float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready_state():
	idle_time = randf_range(1.8, 2.4)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_state(delta):
	elasped_time += delta
	if (elasped_time > 0.2 and !has_shot):
		var new_shot = shot.instantiate()
		new_shot._data_init(5 + Globals.Difficulty, true, shot_spawner.global_position, 600, Vector2(-1, 0), 0)
		has_shot = true
		add_child(new_shot)
	if (elasped_time > idle_time):
		next_state.emit(get_node("../MoveToPlayerState"))

func _prepare_state():
	elasped_time = 0.0
	has_shot = false

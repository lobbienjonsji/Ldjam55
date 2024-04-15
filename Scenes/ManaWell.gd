extends Area2D

signal update_global_position(vector : Vector2)
signal update_global_grid_position(vector : Vector2)
signal recharge_player(amount : float)
var current_pos :  Vector2 = Vector2(50, 50)
var current_grid_pos :  Vector2i = Vector2i(0, 0)
var player_adjacency : Array[Vector2i] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if(Globals.PlayerPos in player_adjacency):
			if($ManaBar._pay_mana(0.1)):
				recharge_player.emit(0.1)

func _on_timer_timeout():
	$ManaBar._recharge(0.2)

func _init_position(grid_pos : Vector2i):
	current_pos = grid_pos * 100 + Vector2i(50, 50)
	global_position = current_pos
	current_grid_pos = grid_pos
	update_global_position.emit(current_pos)
	update_global_grid_position.emit(current_grid_pos)
	for i in range(-1, 2):
		for j in range(-1, 2):
			player_adjacency.append(Vector2i(i, j) + current_grid_pos)

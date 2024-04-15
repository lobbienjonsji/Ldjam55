class_name MovementHandler
extends Node2D
var is_moving : bool = false
var previous_pos : Vector2 = Vector2(50, 50)
var target_pos : Vector2 = Vector2(50, 50)
var current_pos :  Vector2 = Vector2(50, 50)
var current_grid_pos :  Vector2i = Vector2i(0, 0)
var target_grid_pos : Vector2i = Vector2i(0, 0)
var move_timer : float = 0.0
var valid_locations_x : Array[Vector2i]
var valid_locations_y : Array[Vector2i]
@export var velocity = 0.0
signal try_move(old_pos : Vector2i, new_pos : Vector2i, movement_handler : MovementHandler)
signal update_locations(location : Vector2i, handler : MovementHandler)
signal update_global_position(vector : Vector2)
signal update_global_grid_position(vector : Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init_position(grid_pos : Vector2i):
	previous_pos = grid_pos * 100 + Vector2i(50, 50)
	target_pos = grid_pos * 100 + Vector2i(50, 50)
	current_pos = grid_pos * 100 + Vector2i(50, 50)
	current_grid_pos = grid_pos
	target_grid_pos = grid_pos
	update_global_position.emit(current_pos)
	update_global_grid_position.emit(current_grid_pos)

func _recieve_input_vector(velocity : Vector2i):
	if not is_moving:
		try_move.emit(current_grid_pos, current_grid_pos + velocity, self)		

func _update_locations():
	update_locations.emit(current_grid_pos, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		move_timer += velocity * delta
		if move_timer >= 1:
			move_timer = 1
		current_pos = previous_pos.lerp(target_pos, move_timer)
		update_global_position.emit(current_pos)
		if move_timer == 1:
			current_grid_pos = target_grid_pos
			is_moving = false
			move_timer = 0
	
func _set_new_target(target : Vector2i):
	previous_pos = current_pos
	target_grid_pos = target
	update_global_grid_position.emit(target)
	target_pos = target * 100 + Vector2i(50, 50)
	is_moving = true

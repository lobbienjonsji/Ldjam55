class_name MoveToPlayerState
extends State

@export var movement_handler : MovementHandler

# Called when the node enters the scene tree for the first time.
func _ready_state():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_state(delta):
	movement_handler._update_locations()
	var movement = Vector2i(0, 0)
	if movement_handler.current_grid_pos.y < Globals.PlayerPos.y:
		movement = Vector2i(0, 1)
	elif movement_handler.current_grid_pos.y > Globals.PlayerPos.y:
		movement = Vector2i(0, -1)
	else: 
		next_state.emit(get_node("../ShootState"))
	if not movement in movement_handler.valid_locations_y and not movement_handler.valid_locations_x.is_empty():
		movement = movement_handler.valid_locations_x[randi() % movement_handler.valid_locations_x.size()]
	movement_handler._recieve_input_vector(movement)

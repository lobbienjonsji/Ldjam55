extends TileMap
var is_valid = false
var is_active = false
var crystalScene : PackedScene = preload("res://Scenes/ManaCrystal.tscn")
var leyLineScene : PackedScene = preload("res://Scenes/Leyline.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _try_move(old_pos : Vector2i, pos : Vector2i, movement_handler : MovementHandler):
	if get_cell_source_id(0, pos) == -1:
		movement_handler._set_new_target(pos)
		set_cell(0, old_pos, -1)
		set_cell(0, pos, 4, Vector2i(0, 0), 0)
	

func _try_summon(mana : ManaBar):
	if(is_active && is_valid):
		if(mana._pay_mana(1)):
			var current_mouse = to_local(get_global_mouse_position())
			var cell_hovered = local_to_map(current_mouse)
			var crystal = crystalScene.instantiate()
			add_child(crystal)
			crystal._init_position(cell_hovered)
			crystal.destroy.connect(_destroy_node)
			_occupy(cell_hovered)

func _get_valid_locations(position : Vector2i, handler : MovementHandler):
	handler.valid_locations_x.clear()
	handler.valid_locations_y.clear()
	for i in [1, -1]:
		if get_cell_source_id(0, position + Vector2i(i, 0)) == -1:
			handler.valid_locations_x.append(Vector2i(i, 0))
		if get_cell_source_id(0, position + Vector2i(0, i)) == -1:
			handler.valid_locations_y.append(Vector2i(0, i))

func _occupy(pos : Vector2i):
	set_cell(0, pos, 4, Vector2i(0, 0), 0)

func _get_spawn_locations() -> Array:
	var retval = []
	for i in range(9, 18):
		for j in range(0, 8):
			var vec = Vector2i(i,j)
			if get_cell_source_id(0, vec) == -1:
				retval.append(vec)
	return retval

func _get_spawn_locations_player() -> Array:
	var retval = []
	for i in range(0, 8):
		for j in range(0, 8):
			var vec = Vector2i(i,j)
			if get_cell_source_id(0, vec) == -1:
				retval.append(vec)
	return retval

func _destroy_node(toVoid : Vector2i):
	set_cell(0, toVoid, -1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_mouse = to_local(get_global_mouse_position())
	var cell_hovered = local_to_map(current_mouse)
	$MouseAnchor.set_position(map_to_local(cell_hovered))
	is_valid = get_cell_source_id(0, cell_hovered) == -1
	is_active = get_cell_source_id(1, cell_hovered) != -1
	$MouseAnchor/MouseGridHover._change_color(is_valid, is_active)
	

func _summon_coin():
	var spaces = _get_spawn_locations_player()
	var location = spaces[randi() % spaces.size()]
	set_cell(2, location, 4, Vector2i(0, 0), 1)

func _summon_leyline():
		var x = randi_range(0, 7)
		for y in range(8):
			var leyline = leyLineScene.instantiate()
			add_child(leyline)
			leyline._init_position(Vector2i(x,y))
		$"../LeylineTimer".start(5/(Globals.Difficulty/2 + 1))



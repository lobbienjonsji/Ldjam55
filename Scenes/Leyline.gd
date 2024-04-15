extends Node2D
@onready var area : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area = $Area2D
	remove_child($Area2D)
	$Eruption.set_visible(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _erupt():
	add_child(area)
	$Eruption.set_visible(true)
	$Warning.set_visible(false)

func _destroy():
	queue_free()

func _init_position(grid_pos : Vector2i):
	var current_pos = grid_pos * 100 + Vector2i(50, 50)
	global_position = current_pos

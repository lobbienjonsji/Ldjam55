extends Area2D
signal destroy(voidAt : Vector2i)

# Called when the node enters the scene tree for the first time.
func _ready():
	$MovementHandler.update_global_position.connect(_update_position)
	Globals.MonsterCount += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_position(target : Vector2):
	global_position = target


func _on_health_bar_on_death():
	destroy.emit($MovementHandler.target_grid_pos)
	Globals.MonsterCount -= 1
	Globals.Score += 1
	queue_free()

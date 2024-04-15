extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _change_color(is_valid : bool, is_active : bool):
	visible = is_active
	if is_valid:
		color = Color(0.565, 1, 0.38, 0.314)
	else :
		color = Color(0.902, 0.31, 0.482, 0.314)
	

class_name Player
extends Area2D
signal try_summon(mana : ManaBar)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2i.ZERO
	if Input.is_action_just_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_just_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_just_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_just_pressed("move_up"):
		velocity.y -= 1
	if velocity != Vector2i(0, 0):
		$MovementHandler._recieve_input_vector(velocity)
	if Input.is_action_just_pressed("click_left"):
		try_summon.emit($ManaBar)

func _on_death():
	get_tree().change_scene_to_file("res://Scenes/Menu/GameOverMenu.tscn")

func _update_position(target : Vector2):
	global_position = target

func _on_collision(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
	if(area.has_meta("is_coin")):
		area.queue_free()
		Globals.Score += 1
		$ManaBar._recharge(2.0)

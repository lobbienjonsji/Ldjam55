extends Node

var Difficulty : int = 0
var PlayerPos : Vector2i = Vector2i(0,0)
var MonsterCount : int = 0
var RockCount : int = 0
var Grid : TileMap
var Score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_player_pos(pos : Vector2):
	PlayerPos = pos

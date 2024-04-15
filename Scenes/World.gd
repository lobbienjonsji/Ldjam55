extends Node2D

@onready var player : Player

var monster_count : int = 0
var playerScene : PackedScene = preload("res://Scenes/Player.tscn")
var monsterScene : PackedScene = preload("res://Scenes/Spirit.tscn")
var monsterScene2 : PackedScene = preload("res://Scenes/LargeRock.tscn")
var wellScene : PackedScene = preload("res://Scenes/ManaWell.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.Grid = $WorldGrid
	Globals.MonsterCount = 0
	Globals.Score = 0
	Globals.Difficulty = 0
	randomize()
	$WaveTimer.start()
	$WaveTimer.timeout.connect(_spawn_wave)
	player = playerScene.instantiate()
	add_child(player)
	player.get_node("MovementHandler").try_move.connect($WorldGrid._try_move)
	player.get_node("MovementHandler").update_global_grid_position.connect(Globals._update_player_pos)
	player.get_node("MovementHandler")._init_position(Vector2i(0,3))
	player.try_summon.connect($WorldGrid._try_summon)
	$WorldGrid._occupy(Vector2(0, 3))
	for i in [0, 7] :
		var well = wellScene.instantiate()
		add_child(well)
		well._init_position(Vector2i(0,i))
		well.recharge_player.connect(player.get_node("ManaBar")._recharge)
		$WorldGrid._occupy(Vector2(0, i))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ScoreLabel.set_text("Score: %s" % [Globals.Score])
	
func _spawn_wave():
	if(Globals.MonsterCount < 4 + Globals.Difficulty):
		var spaces = $WorldGrid._get_spawn_locations()
		var location = spaces[randi() % spaces.size()]
		var monster = monsterScene.instantiate()
		add_child(monster)
		monster.get_node("MovementHandler").try_move.connect($WorldGrid._try_move)
		monster.get_node("MovementHandler").update_locations.connect($WorldGrid._get_valid_locations)
		monster.destroy.connect($WorldGrid._destroy_node)
		monster.get_node("MovementHandler")._init_position(location)
		$WorldGrid._occupy(location)
		

func _summon_rock():
	if(Globals.RockCount < 2 + Globals.Difficulty):
		var spaces = $WorldGrid._get_spawn_locations()
		var location = spaces[randi() % spaces.size()]
		var monster = monsterScene2.instantiate()
		add_child(monster)
		monster.destroy.connect($WorldGrid._destroy_node)
		monster._init_position(location)
		$WorldGrid._occupy(location)
	

func _increase_difficulty():
	Globals.Difficulty += 1
	Globals.Score += 1

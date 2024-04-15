class_name ManaBar
extends Node2D

var mana_changed : bool = false
@export var max_mana : float
@onready var cur_mana : float

# Called when the node enters the scene tree for the first time.
func _ready():
	cur_mana = 0
	$Label.set_text("%s/%s" % [cur_mana, max_mana])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mana_changed:
		$ColorRect._set_size(Vector2(100 * cur_mana/max_mana, 20))
		$Label.set_text("%s/%s" % [cur_mana, max_mana])
		mana_changed = false

func _pay_mana(amount : float) -> bool:
	if(amount <= cur_mana):
		cur_mana -= amount
		mana_changed = true
		return true
	return false

func _recharge(amount : float):
	cur_mana = min(max_mana, cur_mana + amount) 
	mana_changed = true

class_name HealthBar
extends Node2D

var health_changed : bool = false
@export var max_hp : int
@export var hitbox : Area2D
@export var is_enemy : bool
@onready var cur_hp : int
signal on_death()

# Called when the node enters the scene tree for the first time.
func _ready():
	cur_hp = max_hp
	$Label.set_text("%s/%s" % [cur_hp, max_hp])
	hitbox.area_shape_entered.connect(_on_collision)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health_changed:
		if cur_hp <= 0:
			on_death.emit()
			return
		$ColorRect._set_size(Vector2(100 * cur_hp/max_hp, 20))
		$Label.set_text("%s/%s" % [cur_hp, max_hp])
		health_changed = false

func _on_collision(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
	if(area.has_meta("dmg") and (!self.is_enemy or !area.get_meta("is_enemy")) and $Iframes.get_time_left() == 0):
		cur_hp = max(cur_hp - area.get_meta("dmg"), 0)
		area.queue_free()
		health_changed = true
		$Iframes.start(0.2)

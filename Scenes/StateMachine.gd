class_name StateMachine
extends Node

@export var init_state : NodePath
@onready var state : State = get_node(init_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	state.next_state.connect(_change_to_new_state)
	state._ready_state()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state._process_state(delta)

func _change_to_new_state(new_state : State):
	state.next_state.disconnect(_change_to_new_state)
	state = new_state
	new_state._prepare_state()
	state.next_state.connect(_change_to_new_state)

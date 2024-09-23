extends State
class_name IdleState

@export
var active_state: State

var myTurn = false

const LOW_ALPHA = 0.6
const HIGH_ALPHA = 1.0
const LOW_Z_IDX = 1
const HIGH_Z_IDX = 2

func set_parent(new_parent : CharacterBody2D):
	super.set_parent(new_parent)
	parent.turn_started.connect(func(): myTurn = true)

func enter() -> void:
	parent.modulate.a = LOW_ALPHA
	parent.set_z_index(LOW_Z_IDX)

func exit() -> void:
	myTurn = false
	parent.modulate.a = HIGH_ALPHA
	parent.set_z_index(HIGH_Z_IDX)

func process_frame(_delta):
	if myTurn:
		return active_state
	return null
	

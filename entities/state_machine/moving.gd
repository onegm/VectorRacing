extends State
class_name MovingState

@export
var idle_state: State
@export
var crashing_state: State
@export
var finished_state : State

var crashed = false
var finished = false
var moving_time = 0.0

func set_parent(new_parent : CharacterBody2D):
	super(new_parent)
	parent.crashed.connect(func(): crashed = true)
	parent.finished.connect(func(): finished = true)

func enter() -> void:
	crashed = false
	moving_time = 0
	parent.increment_moves()


func process_physics(delta: float) -> State:
	parent.move_and_slide()
	moving_time += delta
	
	if crashed:
		return crashing_state
		
	if moving_time >= 1.0 || (parent.velocity.length() < 0.01 && moving_time > 0.1):
		return idle_state
		
	if finished:
		return finished_state
		
	return null

func exit():
	parent.turn_ended.emit()

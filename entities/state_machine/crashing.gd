extends State
class_name CrashingState

@export
var idle_state : State

const CRASH_PENALTY = 5

func enter() -> void:
	parent.set_global_position(parent.target - parent.velocity)
	parent.set_velocity(Vector2.ZERO)
	parent.set_acceleration(Vector2.ZERO)
	parent.increment_moves(CRASH_PENALTY)

func process_frame(_delta: float) -> State:
	return idle_state

extends State
class_name CrashingState

@export
var idle_state : State

const CRASH_PENALTY = 5

func enter() -> void:
	AudioManager.crash_sound.play(0.38)
	await AudioManager.crash_sound.finished
	parent.set_global_position(parent.target - parent.velocity)
	parent.set_velocity(Vector2.ZERO)
	parent.set_acceleration(Vector2.ZERO)
	parent.increment_moves(CRASH_PENALTY)
	parent.turn_ended.emit()

func process_frame(_delta: float) -> State:
	return idle_state

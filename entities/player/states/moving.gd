extends State
class_name MovingState

@export var idle_state: State
@export var crashing_state: State
@export var finished_state : State

var crashed = false
var turn_ended = false
var finished = false
var tween : Tween

func set_parent(new_parent : CharacterBody2D):
	super.set_parent(new_parent)
	parent.finished.connect(func(): finished = true)

func enter() -> void:
	crashed = false
	turn_ended = false
	parent.crashed = false
	parent.increment_moves()
	play_sound()
	set_motion_properties()

func play_sound():
	AudioManager.engine_sound.set_pitch_scale(1 + parent.velocity.length() / 250)
	AudioManager.engine_sound.play()

func set_motion_properties():
	if is_zero_approx(parent.velocity.length()): 
		turn_ended = true
		return
	tween = create_tween()
	tween.finished.connect(end_turn)
	tween.tween_property(parent, "global_position", parent.target, 1.0)

func end_turn():
	turn_ended = true

func process_physics(_delta: float) -> State:
	if parent.crashed:
		tween.kill()
		return crashing_state
	
	if finished:
		return finished_state
	
	if turn_ended:
		parent.turn_ended.emit()
		return idle_state
		
	return null

func exit():
	AudioManager.engine_sound.stop()
	if crashed:
		for i in range(CrashingState.CRASH_PENALTY):
			parent.velocity_record.append(Vector2.ZERO)
		return
	parent.velocity_record.append(parent.velocity)

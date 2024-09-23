extends State

@export var idle_state : State

var velocity_record := []
var finished := false

@onready var timer : Timer = Timer.new()

func enter() -> void:
	finished = false
	SignalBus.update_replay_velocity.connect(update_velocity)
	velocity_record = parent.velocity_record.duplicate()
	parent.velocity = Vector2.ZERO
	parent.global_position = Vector2(parent.initial_state.x, parent.initial_state.y)
	parent.global_rotation = parent.initial_state.z
	parent.replay_particles.restart()

func process_physics(_delta: float) -> State:
	parent.move_and_slide()
	if finished : return idle_state
	return null

func update_velocity():
	var new_velocity = velocity_record.pop_front()
	parent.velocity = new_velocity if new_velocity else Vector2.ZERO
	finished = new_velocity == null
	parent.look_at(parent.global_position + parent.velocity)

func exit():
	parent.replay_particles.emitting = false
	SignalBus.update_replay_velocity.disconnect(update_velocity)
	SignalBus.player_ended_replay.emit()

extends State

@export var idle_state : State 

var velocity_record := []
var finished = true

@onready var timer : Timer = Timer.new()

func _ready() -> void:
	SignalBus.update_replay_velocity.connect(update_velocity)

func enter() -> void:
	velocity_record = parent.velocity_record.duplicate()
	parent.velocity = Vector2.ZERO
	parent.global_position = Vector2(parent.initial_state.x, parent.initial_state.y)
	parent.global_rotation = parent.initial_state.z
	parent.replay_particles.restart()

func process_physics(_delta: float) -> State:
	parent.move_and_slide()
	if finished:
		return 
	return null

func update_velocity():
	var new_velocity = velocity_record.pop_front()
	parent.velocity = new_velocity if new_velocity else Vector2.ZERO
	if new_velocity == null: 
		parent.replay_particles.emitting = false
		SignalBus.player_ended_replay.emit()
		return
	parent.look_at(parent.global_position + parent.velocity)

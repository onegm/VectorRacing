class_name Player
extends CharacterBody2D

@onready var state_machine : StateMachine = $StateMachine
@onready var vehicle : AnimatedSprite2D = $Vehicle
@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var replaying_state : State = $StateMachine/Replaying
@onready var replay_particles : GPUParticles2D = $Vehicle/ReplayTrailParticles

var vehicle_color : Color

var moves = 0
var acceleration = Vector2.ZERO
var target = Vector2.ZERO
var initial_state : Vector3 
var velocity_record : Array = []

signal turn_started
signal turn_ended
signal crashed
signal finished
signal moves_changed
signal acceleration_changed

func _ready() -> void:
	state_machine.init(self)
	vehicle.set_modulate(vehicle_color)
	initial_state = Vector3(global_position.x, global_position.y, global_rotation)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func increment_moves(num_moves : int = 1):
	moves += num_moves
	moves_changed.emit()

func set_acceleration(acc : Vector2):
	acceleration = acc
	target = global_position + velocity + acceleration
	acceleration_changed.emit()

func update_velocity():
	velocity += acceleration
	set_acceleration(Vector2.ZERO)
	look_at(global_position + velocity)

func is_in_motion():
	return state_machine.current_state is MovingState

func is_active():
	return !(state_machine.current_state is FinishedState)

func get_moves():
	return moves

func set_color(color : Color):
	vehicle_color = color
	if vehicle == null: return
	vehicle.set_modulate(vehicle_color)

func start_replay():
	state_machine.change_state(replaying_state)

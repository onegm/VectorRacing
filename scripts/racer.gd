extends CharacterBody2D
class_name Racer

@onready var vehicle = $Vehicle
@onready var current_target = global_position
@onready var temp_target = global_position

var tile_size = Game.TILE_SIZE

var is_in_motion = false
var initial_position
var vehicle_color : Color
var moves = 0

const HIGH_ALPHA = 1.0
const LOW_ALPHA = 0.6
const HIGH_Z_IDX = 1
const LOW_Z_IDX = 0

signal started_moving(move_velocity : Vector2)
signal updated_target(target_change_vector : Vector2)
signal crashed
signal resetted
signal my_turn_started
signal my_turn_ended

func _ready():
	colorize()
	my_turn_started.connect(on_my_turn_started)
	my_turn_ended.connect(on_my_turn_ended)
	modulate.a = LOW_ALPHA
	

func _physics_process(delta):
	var distance_from_target = (current_target - global_position).length()

	if is_in_motion:
		global_position += velocity*delta
		if distance_from_target < 5:
			global_position = current_target
			stop_moving()

func set_initial_position(new_position : Vector2 = Vector2.ZERO):
	initial_position = new_position
	global_position = new_position
	current_target = new_position

func update_target_position(dx:float, dy:float):
	var target_change_vector = Vector2(dx*tile_size, dy*tile_size)
	temp_target = global_position + velocity + target_change_vector
	updated_target.emit(target_change_vector)

func on_my_turn_started():
	modulate.a = HIGH_ALPHA
	set_z_index(HIGH_Z_IDX)
	

func on_my_turn_ended():
	modulate.a = LOW_ALPHA
	set_z_index(LOW_Z_IDX)
	
func move():
	if is_in_motion:
		return
		
	moves += 1
	current_target = temp_target
	velocity = current_target - global_position
	start_moving()

func reset(new_position : Vector2 = initial_position):
	global_position = new_position
	velocity = Vector2.ZERO
	current_target = new_position
	temp_target = new_position
	stop_moving()

func crash_reset():
	var pre_crash_position = current_target - velocity
	moves += 5
	reset(pre_crash_position)
	crashed.emit()
	
func start_moving():
	is_in_motion = true
	started_moving.emit(velocity)
	
func stop_moving():
	is_in_motion = false
	my_turn_ended.emit()

func get_moves():
	return moves
	
func set_color(color : Color):
	vehicle_color = color

func colorize():
	vehicle.set_modulate(vehicle_color)

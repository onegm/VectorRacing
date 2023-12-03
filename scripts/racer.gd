extends CharacterBody2D
class_name Racer

@onready var vehicle = $Vehicle
@onready var motion_vectors = $MotionVectors
@onready var current_target = global_position
@onready var temp_target = global_position

var tile_size = Game.TILE_SIZE

var is_in_motion = false
var initial_position
var vehicle_color : Color
var moves = 0

func _ready():
	colorize()

func _physics_process(delta):
	var distance_from_target = (current_target - global_position).length()

	if is_in_motion:
		global_position += velocity*delta
		if distance_from_target < 5:
			global_position = current_target
			is_in_motion = false

func set_initial_position(new_position : Vector2 = Vector2.ZERO):
	initial_position = new_position
	global_position = new_position
	current_target = new_position

func update_target_position(dx:float, dy:float):
	var target_change_vector = Vector2(dx*tile_size, dy*tile_size)
	temp_target = global_position + velocity + target_change_vector
	motion_vectors.set_new_acceleration(target_change_vector)
	
func move():
	if is_in_motion:
		return
		
	moves += 1
	current_target = temp_target
	velocity = current_target - global_position
	motion_vectors.set_new_velocity(velocity)
	is_in_motion = true

func reset(new_position : Vector2 = initial_position):
	global_position = new_position
	velocity = Vector2.ZERO
	current_target = new_position
	temp_target = new_position
	motion_vectors.reset()
	is_in_motion = false

func crash_reset():
	var pre_crash_position = current_target - velocity
	moves += 5
	print(moves)
	reset(pre_crash_position)

func get_moves():
	return moves
	
func set_color(color : Color):
	vehicle_color = color

func colorize():
	vehicle.set_modulate(vehicle_color)

extends CharacterBody2D
class_name Racer

@onready var vehicle = $Vehicle
@onready var motion_vectors = $MotionVectors
@onready var current_target = global_position

var tile_size = Game.TILE_SIZE
var is_active = false

var initial_position
var vehicle_color : Color

func _ready():
	colorize()

func _physics_process(delta):
	var distance_from_target = (current_target - global_position).length()

	if is_active:
		global_position += velocity*delta
		if distance_from_target < 5:
			global_position = current_target
			is_active = false

func set_initial_position(new_position : Vector2 = Vector2.ZERO):
	initial_position = new_position
	global_position = new_position
	current_target = new_position

func update_target_position(dx:float, dy:float):
	var target_change_vector = Vector2(dx*tile_size, dy*tile_size)
	current_target = global_position + velocity + target_change_vector
	motion_vectors.set_new_acceleration(target_change_vector)
	
func move():
	if is_active:
		return
		
	velocity = current_target - global_position
	motion_vectors.set_new_velocity(velocity)
	is_active = true

func reset(new_position : Vector2 = initial_position):
	global_position = new_position
	velocity = Vector2.ZERO
	current_target = new_position
	motion_vectors.reset()
	is_active = false

func crash_reset():
	var pre_crash_position = global_position - velocity
	reset(pre_crash_position)
	
func set_color(color : Color):
	vehicle_color = color

func colorize():
	vehicle.set_modulate(vehicle_color)

extends Node2D
class_name Racer

@onready var target = $Target
@onready var vehicle = $Vehicle
@onready var velocity_vector = $VelocityVector

var tile_size = Game.TILE_SIZE

var initial_position

func set_initial_position(new_position : Vector2 = Vector2.ZERO):
	initial_position = new_position
	global_position = new_position

func update_target_position(dx:int, dy:int):
	target.update_position(dx, dy)

func move():
	vehicle.move_to_target(target.global_position)
	target.set_anchor(target.global_position + vehicle.velocity)
	velocity_vector.set_global_position(target.global_position)

func reset():
	vehicle.set_velocity(Vector2.ZERO)
	vehicle.set_global_position(initial_position)
	target.set_anchor(initial_position)
	
func set_color(color : Color):
	vehicle.set_color(color)
	target.set_color(color)

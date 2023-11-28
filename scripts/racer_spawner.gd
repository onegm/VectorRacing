extends Node2D


@export var racer_scene : PackedScene = null

var racers = []
var spawn_points

#func _ready():
#	spawn_racers()
#	for racer in racers:
#		racer.set_name("RACER")
#		add_child(racer)
#		print(racer.global_position)
#		print(racer.vehicle.global_position)
#		print(racer.target_marker.global_position)

func spawn_racers(num : int, spawn_position: Vector2, spawn_rotation : float):
	if num == 1:
		spawn_points = $OnePlayer
	else:
		spawn_points = $TwoPlayers
	set_spawn_position_center(spawn_position)
	set_spawn_rotation(spawn_rotation)
	for i in num:
		var spawn_point = spawn_points.get_children()[i]
		var racer_instance = racer_scene.instantiate()
		racer_instance.set_initial_position(spawn_point.global_position)
		racers.append(racer_instance)
	return racers

func set_spawn_position_center(spawn_position: Vector2):
	spawn_points.set_global_position(spawn_position)

func set_spawn_rotation(spawn_rotation):
	spawn_points.rotate(spawn_rotation) 

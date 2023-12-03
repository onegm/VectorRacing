extends Node2D

@export var racer_scene : PackedScene = null

var racers = []
var spawn_points
var colors = [Color.BLUE, Color.RED, Color.BLACK, Color.DARK_GREEN]
var names = ["Blue", "Red", "Black", "Green"]

func spawn_racers(num_players : int, spawn_position: Vector2, spawn_rotation : float):
	set_spawn_points(num_players)
	set_spawn_position_center(spawn_position)
	set_spawn_rotation(spawn_rotation)
	for i in num_players:
		var spawn_point = spawn_points.get_children()[i]
		var racer = racer_scene.instantiate()
		racer.set_initial_position(spawn_point.global_position)
		racer.set_color(colors[i])
		racer.set_name(names[i])
		racers.append(racer)
	return racers

func set_spawn_points(num_players):
	if num_players == 1:
		spawn_points = $OnePlayer
	elif num_players == 2:
		spawn_points = $TwoPlayers
	else:
		spawn_points = $ThreePlayers

func set_spawn_position_center(spawn_position: Vector2):
	spawn_points.set_global_position(spawn_position)

func set_spawn_rotation(spawn_rotation):
	spawn_points.rotate(spawn_rotation) 

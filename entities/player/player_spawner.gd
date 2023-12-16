extends Node2D
class_name PlayerSpawner

@export var player_scene : PackedScene = null
@onready var num_players = Game.num_players

var players = []
var spawn_points
var colors = [Color.BLUE, Color.RED, Color.PURPLE, Color.DARK_GREEN]
var names = ["Blue", "Red", "Purple", "Green"]

func spawn_players(spawn_position: Vector2, spawn_rotation : float):
	set_spawn_points().center(spawn_position).rotation(spawn_rotation)
	for i in Game.num_players:
		var spawn_point = spawn_points.get_children()[i]
		var player = player_scene.instantiate()
		player.set_global_position(spawn_point.global_position)
		player.set_color(colors[i])
		player.set_name(names[i])
		SignalBus.player_spawned.emit(player)

func set_spawn_points():
	match Game.num_players:
		1:
			spawn_points = $OnePlayer
		2:
			spawn_points = $TwoPlayers
		3:
			spawn_points = $ThreePlayers
	return self

func center(spawn_position: Vector2):
	spawn_points.set_global_position(spawn_position)
	return self
	
func rotation(spawn_rotation):
	spawn_points.rotate(spawn_rotation)
	return self

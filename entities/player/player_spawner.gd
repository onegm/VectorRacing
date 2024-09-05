extends Node2D
class_name PlayerSpawner

static var player_scene : PackedScene = load("res://entities/player/player.tscn")
const PLAYER_SEPARATION = Vector2.DOWN*(Game.TILE_SIZE)

static func spawn_players(spawn_position: Vector2, spawn_rotation : float):
	var colors = [Color.DODGER_BLUE, Color.RED, Color.PURPLE, Color.DARK_GREEN]
	var names = ["Blue", "Red", "Purple", "Green"]
	var positions = get_spawn_positions(spawn_position, spawn_rotation)
	for i in Game.num_players:
		var player = player_scene.instantiate()
		player.set_global_position(positions[i])
		player.set_color(colors[i])
		player.set_name(names[i])
		SignalBus.player_spawned.emit(player)
	
static func get_spawn_positions(spawn_position, spawn_rotation):
	spawn_rotation *= PI / 180
	match Game.num_players:
		1: return [spawn_position]
		2: return [
			spawn_position - PLAYER_SEPARATION.rotated(spawn_rotation)*0.7,
			spawn_position + PLAYER_SEPARATION.rotated(spawn_rotation)*0.7
		]
		3: return [
			spawn_position - PLAYER_SEPARATION.rotated(spawn_rotation),
			spawn_position,
			spawn_position + PLAYER_SEPARATION.rotated(spawn_rotation)
		]

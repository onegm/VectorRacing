extends Node2D
class_name Level

@export var ui_scene : PackedScene = preload("res://entities/ui/ui.tscn")
@export var track_scene : PackedScene
@export var camera_scene : PackedScene = preload("res://entities/camera/camera_2d.tscn")

@onready var ui = ui_scene.instantiate()
@onready var track = track_scene.instantiate()
@onready var camera = camera_scene.instantiate()

var players = []
var current_player : CharacterBody2D
var current_player_idx = 0
var finishers = []
var race_is_active = true
var min_moves = 2**60

func _ready():
	SignalBus.player_spawned.connect(on_player_spawned)
	
	add_child(track)
	add_child(ui)
	add_child(camera)
	
	PlayerSpawner.spawn_players(track.get_spawn_point(), track.spawn_rotation)
	
	for player in players:
		player.turn_ended.connect(on_player_turn_ended)
	
	current_player = players[current_player_idx]
	current_player.turn_started.emit()
	
	camera.follow(players)
	
	track.track_exited.connect(on_track_exited)
	track.player_won.connect(on_player_finished)

func _process(_delta):
	if any_player_in_motion() || !race_is_active:
		return
	check_race_ended()

func on_track_exited(crashed_player : CharacterBody2D):
	crashed_player.crashed.emit()

func on_player_spawned(player : CharacterBody2D):
	add_child(player)
	players.append(player)

func on_player_finished(finished_player : CharacterBody2D):
	finishers.append(finished_player)
	finished_player.finished.emit()
	update_min_moves()

func update_min_moves():
	for finisher in finishers:
		min_moves = min(min_moves, finisher.get_moves())

func check_race_ended():
	if players.all(func(player) : return player.get_moves() >= min_moves):
		end_race()
			
func end_race():
	race_is_active = false
	var winners = determine_winner()
	SignalBus.race_ended.emit(winners)
	get_tree().paused = true

func determine_winner():
	var winners = []
	for finisher in finishers:
		if finisher.get_moves() <= min_moves:
			winners.append(finisher)
	return winners

func on_player_turn_ended():
	if no_players_active(): return
		
	current_player_idx += 1
	if(current_player_idx >= players.size()):
		current_player_idx = 0
		
	while(!players[current_player_idx].is_active()):
		current_player_idx += 1
		if(current_player_idx >= players.size()):
			current_player_idx = 0
			
	current_player = players[current_player_idx]
	current_player.turn_started.emit()
	
func any_player_in_motion() -> bool:
	return players.any(func(player): return player.is_in_motion())

func no_players_active():
	return players.all(func(player) : return !player.is_active())

func reset():
	for player in players:
		player.reset()
	current_player_idx = 0
	current_player = players[0]
	current_player.my_turn_started.emit()

extends Node2D
class_name RaceManager

@export var ui_scene : PackedScene = preload("res://ui/ui.tscn")

@onready var ui = ui_scene.instantiate()
@onready var track = load("res://entities/tracks/track_" + str(Game.current_track) + ".tscn").instantiate()

@onready var replay_timer := ReplayTimer.new()
var active_replay_players : int

var players = []
var current_player : CharacterBody2D
var current_player_idx : int = 0
var finishers = []
var race_is_active := true
var min_moves = 2**10

func _ready():
	get_tree().paused = false
	connect_signal_bus()
	add_children()
	connect_track_signals()
	spawn_players()
	print(players)
	for player in players:
		player.turn_ended.connect(on_player_turn_ended)
	set_current_player(0)
	
	SignalBus.race_loaded.emit()

func connect_signal_bus():
	SignalBus.player_spawned.connect(on_player_spawned)
	SignalBus.replay_started.connect(on_replay_started)
	SignalBus.player_ended_replay.connect(on_player_ended_replay)

func add_children():
	add_child(track)
	add_child(ui)
	add_child(replay_timer)

func connect_track_signals():
	track.track_exited.connect(on_track_exited)
	track.player_won.connect(on_player_finished)

func on_track_exited(crashed_player : CharacterBody2D):
	crashed_player.crashed.emit()

func on_player_finished(finished_player : CharacterBody2D):
	finishers.append(finished_player)
	finishers.sort_custom(func(a, b): return a.moves < b.moves)
	finished_player.finished.emit()
	update_min_moves()

func update_min_moves():
	for finisher in finishers:
		min_moves = min(min_moves, finisher.get_moves())

func spawn_players():
	PlayerSpawner.spawn_players(track.get_spawn_point(), track.spawn_rotation)
	track.camera_follow(players)

func on_player_turn_ended():
	if no_players_active(): return
	next_player()
	
func next_player():
	var next_player_idx = wrap(current_player_idx + 1, 0, players.size())
	while(!players[next_player_idx].is_active()):
		next_player_idx = wrap(next_player_idx + 1, 0, players.size())
	
	set_current_player(next_player_idx)

func set_current_player(idx):
	current_player_idx = idx
	current_player = players[idx]
	current_player.turn_started.emit()

func _process(_delta):
	if any_player_in_motion() || !race_is_active:
		return
	check_race_ended()

func check_race_ended():
	if players.all(func(player) : return player.get_moves() >= min_moves):
		end_race()

func on_player_spawned(player : CharacterBody2D):
	add_child(player)
	players.append(player)

func on_replay_started():
	active_replay_players = players.size()
	for player in players:
		player.start_replay()
	get_tree().paused = false
	replay_timer.start()

func on_player_ended_replay():
	active_replay_players -= 1
	if active_replay_players <= 0:
		replay_timer.stop()
		SignalBus.replay_ended.emit()

func end_race():
	race_is_active = false
	var winners = determine_winner()
	SignalBus.race_ended.emit(winners, finishers)

func determine_winner():
	var winners = []
	for finisher in finishers:
		if finisher.get_moves() <= min_moves:
			winners.append(finisher)
	return winners
	
func any_player_in_motion() -> bool:
	return players.any(func(player): return player.is_in_motion())

func no_players_active():
	return players.all(func(player) : return !player.is_active())

func _exit_tree():
	SignalBus.race_unloaded.emit()

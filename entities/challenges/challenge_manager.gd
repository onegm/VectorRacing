extends Node2D
class_name ChallengeManager

@export var ui_scene : PackedScene = preload("res://ui/ui.tscn")
@export var challenge_scene : PackedScene = preload("res://entities/challenges/stop_challenge.tscn")

@onready var ui = ui_scene.instantiate()
@onready var replay_timer = Timer.new()

var track : Node

var current_player : CharacterBody2D
var current_player_idx : int = 0
var race_is_active := true
var min_moves = 2**10

func _ready():
	get_tree().paused = false
	track = challenge_scene.instantiate()
	SignalBus.player_spawned.connect(on_player_spawned)
	SignalBus.track_changed.connect(update_track)
	SignalBus.replay_started.connect(on_replay_started)
	SignalBus.player_ended_replay.connect(on_player_ended_replay)
	replay_timer.timeout.connect(SignalBus.update_replay_velocity.emit)
	
	add_child(track)
	add_child(ui)
	add_child(replay_timer)
	
	PlayerSpawner.spawn_players(track.get_spawn_point(), track.spawn_rotation)
	track.camera.follow([current_player])
	current_player.turn_ended.connect(on_player_turn_ended)
	current_player.turn_started.emit()
	
	track.track_exited.connect(on_track_exited)
	track.player_won.connect(on_player_finished)
	SignalBus.race_loaded.emit()

func update_track():
	track = load("res://entities/tracks/track_" + 
				str(Game.current_track) + ".tscn").instantiate()
	
func _process(_delta):
	if any_player_in_motion() || !race_is_active:
		return
	check_race_ended()

func on_track_exited(crashed_player : CharacterBody2D):
	crashed_player.crashed.emit()

func on_player_spawned(player : CharacterBody2D):
	add_child(player)
	current_player = player

func on_player_finished(finished_player : CharacterBody2D):
	finished_player.finished.emit()
	update_min_moves()


func update_min_moves():
	min_moves = min(min_moves, current_player.get_moves())

func check_race_ended():
	pass
			
func end_race():
	race_is_active = false
	pass

func determine_winner():
	pass

func on_player_turn_ended():
	if no_players_active(): return
	current_player.turn_started.emit()
	
func any_player_in_motion() -> bool:
	return current_player.is_in_motion()

func no_players_active():
	return !current_player.is_active()

func on_replay_started():
	replay_timer.one_shot = false
	replay_timer.wait_time = 1.0
	current_player.start_replay()
	get_tree().paused = false
	replay_timer.start()

func on_player_ended_replay():
	replay_timer.stop()
	SignalBus.replay_ended.emit()

func _exit_tree():
	SignalBus.race_unloaded.emit()

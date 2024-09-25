extends Node

signal player_spawned(player : CharacterBody2D)
signal player_crashed()

signal race_loaded()
signal player_finished(player : CharacterBody2D)
signal race_ended(winners : Array, finishers : Array)
signal race_unloaded()

signal replay_started
signal replay_ended
signal player_ended_replay
signal update_replay_velocity

signal leaderboard_score_submitted

signal track_changed()

signal pause_pressed

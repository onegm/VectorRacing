extends Node2D

@export var move_counter_scene : PackedScene = preload("res://ui/hud/move_counter/move_counter.tscn")
@export var motion_vector_scene : PackedScene = preload("res://ui/hud/motion_vectors/motion_vectors.tscn")


var num_players = 0

func _ready():
	SignalBus.player_spawned.connect(on_player_spawned)

func on_player_spawned(player : CharacterBody2D):
	spawn_move_counter(player)
	spawn_motion_vectors(player)

func spawn_move_counter(player : CharacterBody2D):
	var move_counter = move_counter_scene.instantiate()
	add_child(move_counter)
	move_counter.set_player(player)
	move_counter.set_position(Vector2(150 + 300*num_players, 0))
	num_players += 1

func spawn_motion_vectors(player : CharacterBody2D):
	var motion_vectors = motion_vector_scene.instantiate()
	motion_vectors.set_player(player)

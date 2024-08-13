extends Node2D

@export var move_counter_scene : PackedScene = preload("res://entities/ui/hud/move_counter/move_counter.tscn")


var num_players = 0

func _ready():
	SignalBus.player_spawned.connect(on_player_spawned)

func on_player_spawned(player : CharacterBody2D):
	var move_counter = move_counter_scene.instantiate()
	add_child(move_counter)
	move_counter.set_player(player)
	move_counter.set_position(Vector2(150 + 300*num_players, 0))
	num_players += 1	

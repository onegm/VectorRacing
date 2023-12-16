extends Node2D

@export var motion_vector_scene : PackedScene = preload("res://entities/ui/hud/motion_vectors.tscn")

func _ready():
	SignalBus.player_spawned.connect(on_player_spawned)

func on_player_spawned(player : CharacterBody2D):
	var motion_vectors = motion_vector_scene.instantiate()
	motion_vectors.set_player(player)

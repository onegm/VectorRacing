extends Node2D

@export var motion_vector_scene : PackedScene = preload("res://scenes/ui/motion_vectors.tscn")

func _ready():
	SignalBus.racer_spawned.connect(on_racer_spawned)

func on_racer_spawned(racer : Racer):
	var motion_vectors = motion_vector_scene.instantiate()
	motion_vectors.set_racer(racer)

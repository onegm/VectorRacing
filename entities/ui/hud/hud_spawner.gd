extends Node2D

@export var hud_scene : PackedScene = preload("res://entities/ui/hud/hud.tscn")


var num_huds = 0

func _ready():
	SignalBus.player_spawned.connect(on_player_spawned)

func on_player_spawned(player : CharacterBody2D):
	var hud = hud_scene.instantiate()
	add_child(hud)
	hud.set_player(player)
	hud.set_position(Vector2(150 + 300*num_huds, 0))
	num_huds += 1	

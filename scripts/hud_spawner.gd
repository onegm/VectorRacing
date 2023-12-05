extends Node2D

@export var hud_scene : PackedScene = preload("res://scenes/ui/hud.tscn")


var num_huds = 0

func _ready():
	SignalBus.racer_spawned.connect(on_racer_spawned)

func on_racer_spawned(racer : Racer):
	var hud = hud_scene.instantiate()
	hud.set_racer(racer)
	hud.set_position(Vector2(300*num_huds, 0))
	add_child(hud)
	num_huds += 1

extends Node

signal player_spawned(player : CharacterBody2D)
signal player_crashed()

signal race_loaded()
signal race_ended(winners : Array)
signal race_unloaded()

signal vector_mode_changed()
signal input_method_changed()

signal camera_limit_rect_changed(rect : Rect2)
signal track_changed()

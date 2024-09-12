extends Node2D
class_name Track

@onready var inner_track: Area2D = $InnerTrack
@onready var outer_track: Area2D = $OuterTrack
@onready var win_area : Area2D = $WinArea
@onready var camera : Camera2D = $Camera

@export var spawn_rotation : float = 0

signal track_exited
signal player_won

func _ready():
	inner_track.body_entered.connect(on_track_exited)
	outer_track.body_exited.connect(on_track_exited)
	win_area.body_entered.connect(on_win_area_entered)
	Game.set_camera_limit_rect(get_viewport_rect())
	
func on_track_exited(player : CharacterBody2D):
	track_exited.emit(player)
	SignalBus.player_crashed.emit()

func on_win_area_entered(player : CharacterBody2D):
	player_won.emit(player)
	
func get_spawn_point():
	return $SpawnPoint.global_position

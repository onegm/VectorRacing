extends Node2D
class_name Track

@onready var inner_track: Area2D = $InnerTrack
@onready var outer_track: Area2D = $OuterTrack
@onready var win_area : Area2D = $WinArea

@export var spawn_rotation : float = 0

signal track_exited
signal racer_won

func _ready():
	inner_track.body_entered.connect(on_track_exited)
	outer_track.body_exited.connect(on_track_exited)
	win_area.body_entered.connect(on_win_area_entered)
	
func on_track_exited(racer : Racer):
	track_exited.emit(racer)

func on_win_area_entered(racer : Racer):
	racer_won.emit(racer)
	
func get_spawn_point():
	return $SpawnPoint.global_position


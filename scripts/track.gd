extends Node2D

@onready var inner_track: Area2D = $InnerTrack
@onready var outer_track: Area2D = $OuterTrack

signal track_exited

func _ready():
	inner_track.body_entered.connect(on_track_exited)
	outer_track.body_exited.connect(on_track_exited)
	
func on_track_exited(body):
	track_exited.emit(body)
	


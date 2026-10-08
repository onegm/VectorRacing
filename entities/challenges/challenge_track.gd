extends Track

var player : CharacterBody2D

var in_win_zone := false
var velocity_zero := false
var win_conditions = [in_win_zone and velocity_zero]

func _ready() -> void:
	outer_track.body_exited.connect(on_track_exited)
	win_area.body_entered.connect(on_win_area_entered)
	win_area.body_exited.connect(on_win_area_exited)

func _process(_delta: float) -> void:
	if in_win_zone and is_zero_approx(player.get_speed()):
		player_won.emit(player)
		in_win_zone = false

func on_win_area_entered(this_player : CharacterBody2D):
	player = this_player
	in_win_zone = true

func on_win_area_exited(_player : CharacterBody2D):
	in_win_zone = false

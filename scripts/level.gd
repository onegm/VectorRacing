extends Node2D

@onready var track = $Track
@onready var input_manager = $InputManager

var racers
var current_racer
var current_racer_idx = 0
var finishers = []
var race_is_active = true
var min_moves = 2**60

func _ready():
	racers = $RacerSpawner.spawn_racers(Game.num_players, track.get_spawn_point(), track.spawn_rotation)
	for racer in racers:
		add_child(racer)
	current_racer = racers[current_racer_idx]
	
	track.track_exited.connect(on_track_exited)
	track.racer_won.connect(on_racer_finished)
	input_manager.reset_pressed.connect(reset)
	input_manager.next_pressed.connect(on_next_pressed)

func _process(_delta):
	if any_racer_in_motion() || !race_is_active:
		return
	input_manager.read_input(current_racer.global_position)
	current_racer.update_target_position(input_manager.get_x_input(), input_manager.get_y_input())
	
	if all_racers_above_min_moves() && !any_racer_in_motion():
		end_race()

func on_next_pressed():
	if any_racer_in_motion():
		return
	current_racer.move()
	input_manager.reset()
	update_current_racer()
		
func on_track_exited(racer : Racer):
	racer.crash_reset()

func on_racer_finished(racer : Racer):
	finishers.append(racer)
	racers.erase(racer)
	current_racer_idx -= 1
	update_min_moves()

func update_min_moves():
	for racer in finishers:
		if racer.get_moves() < min_moves:
			min_moves = racer.get_moves()
			
func end_race():
	race_is_active = false
	var win_screen = Game.win_screen.instantiate()
	add_child(win_screen)
	win_screen.set_winner(determine_winner())
	win_screen.set_position(get_viewport_rect().size / 2)

func determine_winner():
	var winners = []
	for racer in finishers:
		if racer.get_moves() <= min_moves:
			winners.append(racer)
	return winners

func update_current_racer():
	current_racer_idx += 1
	if(current_racer_idx >= racers.size()):
		current_racer_idx = 0
	current_racer = racers[current_racer_idx]

func any_racer_in_motion() -> bool:
	return racers.any(func(racer): return racer.is_in_motion)

func all_racers_above_min_moves():
	return racers.all(func(racer) : return racer.get_moves() >= min_moves)

func reset():
	for racer in racers:
		racer.reset()
	current_racer_idx = 0
	current_racer = racers[0]

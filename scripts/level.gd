extends Node2D

@onready var track = $Track
@onready var spawn_position = track.get_spawn_point()
@onready var racer_spawner = $RacerSpawner
@onready var input_manager = $InputManager
@onready var num_of_racers = Game.num_of_players

var racers
var current_racer
var current_racer_idx = 0
var winners = []
var final_round = false
var race_is_active = true

func _ready():
	racers = racer_spawner.spawn_racers(num_of_racers, spawn_position, track.spawn_rotation)

	for racer in racers:
		add_child(racer)
		
	current_racer = racers[current_racer_idx]
	
	track.track_exited.connect(on_track_exited)
	track.racer_won.connect(on_racer_finished)
	input_manager.reset_pressed.connect(reset)
	input_manager.next_pressed.connect(on_next_pressed)

func _process(_delta):
	if !race_is_active:
		return
	input_manager.read_input(current_racer.global_position)
	current_racer.update_target_position(input_manager.get_x_input(), input_manager.get_y_input())
	
	if final_round && !any_active_racer() && current_racer_idx == 0 :
		end_race()

func on_next_pressed():
	if any_active_racer():
		return
	current_racer.move()
	input_manager.reset()
	update_current_racer()
		
func on_track_exited(racer : Racer):
	racer.crash_reset()

func on_racer_finished(racer : Racer):
	winners.append(racer)
	final_round = true

func end_race():
	race_is_active = false
	var winner = determine_winner()
	var win_screen = Game.win_screen.instantiate()
	add_child(win_screen)
	win_screen.set_winner(winner)
	win_screen.set_position(get_viewport_rect().size / 2)

func determine_winner():
	var winner = winners[0]
	for racer in winners:
		if racer.get_num_moves() < winner.get_num_moves():
			winner = racer
	
	var num_ties = 0
	for racer in winners:
		if racer.get_num_moves() == winner.get_num_moves():
			num_ties += 1
		if num_ties > 1:
			return null
	return winner

func update_current_racer():
	current_racer_idx += 1
	if(current_racer_idx >= racers.size()):
		current_racer_idx = 0
	current_racer = racers[current_racer_idx]

func any_active_racer() -> bool:
	return racers.any(func(racer): return racer.is_active)

func reset():
	for racer in racers:
		racer.reset()
	current_racer_idx = 0
	current_racer = racers[0]

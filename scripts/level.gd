extends Node2D

@onready var track = $Track
@onready var spawn_position = track.get_spawn_point()
@onready var racer_spawner = $RacerSpawner
@onready var input_manager = $InputManager
@onready var num_of_racers = Game.num_of_players

var racers
var current_racer
var current_racer_idx = 0

var colors = [Color.BLUE, Color.RED, Color.BLACK, Color.DARK_GREEN]

func _ready():
	racers = racer_spawner.spawn_racers(num_of_racers, spawn_position, track.spawn_rotation)
	var i = 0
	for racer in racers:
		add_child(racer)
		racer.set_color(colors[i])
		racer.set_name(str(colors[i]))
		i+=1
		
	current_racer = racers[current_racer_idx]
	
	track.track_exited.connect(on_track_exited)
	track.racer_won.connect(on_racer_won)
	input_manager.reset_pressed.connect(reset)
	input_manager.next_pressed.connect(on_next_pressed)

func _process(_delta):
	input_manager.read_input(current_racer.global_position)
	current_racer.update_target_position(input_manager.get_x_input(), input_manager.get_y_input())

func on_next_pressed():
	if racers.any(func(racer): return racer.is_active):
		return
	current_racer.move()
	update_current_racer()
	input_manager.reset()

func on_track_exited(racer : Racer):
	racer.crash_reset()

func on_racer_won(racer : Racer):
	print(racer.name + " wins!")

func update_current_racer():
	current_racer_idx += 1
	if(current_racer_idx >= racers.size()):
		current_racer_idx = 0
	current_racer = racers[current_racer_idx]

func reset():
	for racer in racers:
		racer.reset()
	current_racer_idx = 0
	current_racer = racers[0]

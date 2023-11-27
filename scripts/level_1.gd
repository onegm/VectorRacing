extends Node2D

@onready var track = $Track
@onready var spawn_point = $SpawnPoint
@onready var racer_spawner = $RacerSpawner
@onready var input_manager = $InputManager
@onready var num_of_racers = Game.num_of_players

var racers
var current_racer
var current_racer_idx = 0

var colors = [Color.BLUE, Color.RED, Color.BLACK, Color.DARK_GREEN]

func _ready():
	racers = racer_spawner.spawn_racers(num_of_racers, spawn_point.global_position)
	var i = 0
	for racer in racers:
		add_child(racer)
		racer.set_color(colors[i])
		i+=1
	
	current_racer = racers[current_racer_idx]
	track.track_exited.connect(on_track_exited)

func _process(_delta):
	input_manager.read_input(current_racer.global_position)
	current_racer.update_target_position(input_manager.get_x_input(), input_manager.get_y_input())

	if Input.is_action_just_pressed("next_move"):
		on_next_pressed()

	if Input.is_action_just_pressed("reset"):
		reset()

func on_next_pressed():
	if racers.any(func(racer): return racer.is_active):
		return
	current_racer.move()
	update_current_racer()
	input_manager.reset()

func on_track_exited(racer):
	await !racer.is_active
	racer.crash_reset()

func update_current_racer():
	current_racer_idx += 1
	if(current_racer_idx >= racers.size()):
		current_racer_idx = 0
	current_racer = racers[current_racer_idx]

func reset():
	for racer in racers:
		racer.reset()
	current_racer_idx = 0

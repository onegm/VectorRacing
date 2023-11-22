extends Node2D

@onready var track = $Track
@onready var spawn_point = $SpawnPoint
@onready var racer_spawner = $RacerSpawner

var racers
var current_racer
var current_racer_idx = 0

var x_change = 0
var y_change = 0

var colors = [Color.BLUE, Color.RED, Color.BLACK, Color.DARK_GREEN]

func _ready():
	racers = racer_spawner.spawn_racers(1, spawn_point.global_position)
	var i = 0
	for racer in racers:
		add_child(racer)
		racer.set_color(colors[i])
		i+=1
		
	current_racer = racers[current_racer_idx]
	track.track_exited.connect(on_track_exited)

#
func _process(delta):

	if Input.is_action_just_pressed("increase_x_speed"):
		if x_change < 1:
			x_change += 1

	elif Input.is_action_just_pressed("decrease_x_speed"):
		if x_change > -1:
			x_change -= 1


	if Input.is_action_just_pressed("increase_y_speed"):
		if y_change > -1:
			y_change -= 1

	if Input.is_action_just_pressed("decrease_y_speed"):
		if y_change < 1:
			y_change += 1

	current_racer.update_target_position(x_change, y_change)

	if Input.is_action_just_pressed("next_move"):
		on_next_pressed()

	if Input.is_action_just_pressed("reset"):
		reset()
#
#
func on_next_pressed():
	current_racer.move()
	update_current_racer()
	x_change = 0
	y_change = 0

func on_track_exited():
	print("track exited!")

func update_current_racer():
	current_racer_idx += 1
	if(current_racer_idx >= racers.size()):
		current_racer_idx = 0
	current_racer = racers[current_racer_idx]

func reset():
	for racer in racers:
		racer.reset()
	x_change = 0
	y_change = 0
	current_racer_idx = 0

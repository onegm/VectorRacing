extends Node2D

@onready var input_mode = Game.input_mode

var x_change = 0
var y_change = 0

signal next_pressed
signal reset_pressed

func _ready():
	SignalBus.input_mode_changed.connect(func(): input_mode = Game.input_mode)
	
func process_player_input(player_global_position : Vector2):
	if input_mode == Game.INPUT_METHOD.KEYBOARD:
		return read_keyboard_input()
	else:
		return read_mouse_input(player_global_position)
	
func read_game_input():
	if Input.is_action_just_pressed("next_move"):
		next_pressed.emit()

	if Input.is_action_just_pressed("reset"):
		reset_pressed.emit()

func read_mouse_input(player_global_position):
	var relative_position = get_global_mouse_position() - player_global_position
	
	if(relative_position.length() < Game.TILE_SIZE/2.0):
		x_change = 0
		y_change = 0
	else:
		var normalized_position = relative_position.normalized()
		x_change = normalized_position.x
		y_change = normalized_position.y
	return Vector2(x_change, y_change)
	
func read_keyboard_input():
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
			
	return Vector2(x_change, y_change)

func reset():
	x_change = 0
	y_change = 0
	


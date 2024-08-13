extends Node2D

@onready var input_method = Game.input_method

var x_change = 0
var y_change = 0

signal next_pressed
signal reset_pressed

func _ready():
	SignalBus.input_method_changed.connect(func(): input_method = Game.input_method)
	
func process_player_input(player_global_position : Vector2) -> Vector2:
	if input_method == Game.INPUT_METHOD.KEYBOARD:
		return read_keyboard_input()
	else:
		return read_mouse_input(player_global_position)

func process_confirmation():
	if input_method == Game.INPUT_METHOD.KEYBOARD:
		return Input.is_action_just_pressed("keyboard_confirm")
	else:
		return Input.is_action_just_pressed("mouse_confirm")

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
	


extends Node2D

@onready var input_method = Game.input_method

var x = 0
var y = 0

signal next_pressed
signal reset_pressed

func _ready():
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	SignalBus.input_method_changed.connect(func(): input_method = Game.input_method)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		SignalBus.pause_pressed.emit()
	
func process_player_input(player_global_position : Vector2) -> Vector2:
	if input_method == Game.INPUT_METHOD.KEYBOARD:
		return read_keyboard_input()
	return read_mouse_input(player_global_position)

func process_confirmation():
	if input_method == Game.INPUT_METHOD.KEYBOARD:
		return Input.is_action_just_pressed("keyboard_confirm")
	else:
		return Input.is_action_just_pressed("mouse_confirm")

func read_mouse_input(player_global_position):
	var relative_position = get_global_mouse_position() - player_global_position
	
	if(relative_position.length() < Game.TILE_SIZE/2.0):
		return Vector2.ZERO
	return relative_position.normalized()
	
func read_keyboard_input(): #REFACTOR
	var x_input = Input.get_axis("decrease_x_speed", "increase_x_speed")
	var y_input = Input.get_axis("increase_y_speed", "decrease_y_speed")
	
	x = clampi(x + x_input, -1, 1)
	y = clampi(y + y_input, -1, 1)
			
	return Vector2(x, y)

func reset():
	x = 0
	y = 0
	

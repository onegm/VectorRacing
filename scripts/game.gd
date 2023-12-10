extends Node

const TILE_SIZE = 22
enum INPUT_METHOD {KEYBOARD, MOUSE}
enum VECTOR_MODE {TAIL_TO_TAIL, HEAD_TO_TAIL}

var vector_mode : VECTOR_MODE = VECTOR_MODE.TAIL_TO_TAIL
var num_players = 1
var input_mode : INPUT_METHOD = INPUT_METHOD.KEYBOARD

@onready var current_level : PackedScene = load("res://scenes/level_1.tscn")
@onready var main_menu : PackedScene = load("res://scenes/start_page.tscn")
@onready var win_screen : PackedScene = load("res://scenes/ui/win_screen.tscn")

func set_num_players(num : int):
	num_players = num
	
func set_vector_mode(mode : VECTOR_MODE):
	vector_mode = mode

func toggle_vector_mode():
	if vector_mode == VECTOR_MODE.TAIL_TO_TAIL:
		set_vector_mode(VECTOR_MODE.HEAD_TO_TAIL)
	else:
		set_vector_mode(VECTOR_MODE.TAIL_TO_TAIL)
	SignalBus.vector_mode_toggled.emit(vector_mode)

func set_input_method(mode : INPUT_METHOD):
	input_mode = mode

func set_current_level(index : int):
	var level = load("res://scenes/level_" + str(index) + ".tscn")
	current_level = level

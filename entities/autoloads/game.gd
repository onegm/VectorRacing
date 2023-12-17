extends Node

const TILE_SIZE = 22
enum INPUT_METHOD {KEYBOARD, MOUSE}
enum VECTOR_MODE {TAIL_TO_TAIL, HEAD_TO_TAIL}

var vector_mode : VECTOR_MODE = VECTOR_MODE.TAIL_TO_TAIL
var input_mode : INPUT_METHOD = INPUT_METHOD.KEYBOARD
var num_players = 3

var level_rect : Rect2

@onready var current_level : PackedScene = load("res://entities/levels/level_1.tscn")
@onready var main_menu : PackedScene = load("res://entities/ui/start_page.tscn")
@onready var win_screen : PackedScene = load("res://entities/ui/win_screen.tscn")

func set_num_players(num : int):
	num_players = num
	
func set_vector_mode(mode : VECTOR_MODE):
	vector_mode = mode

func toggle_vector_mode():
	if vector_mode == VECTOR_MODE.TAIL_TO_TAIL:
		set_vector_mode(VECTOR_MODE.HEAD_TO_TAIL)
	else:
		set_vector_mode(VECTOR_MODE.TAIL_TO_TAIL)
	SignalBus.vector_mode_changed.emit()

func set_input_method(mode : INPUT_METHOD):
	input_mode = mode
	SignalBus.input_mode_changed.emit()

func set_current_level(index : int):
	var level = load("res://entities/levels/level_" + str(index) + ".tscn")
	current_level = level

func set_level_rect(rect : Rect2):
	level_rect = rect
	SignalBus.level_rect_changed.emit(level_rect)

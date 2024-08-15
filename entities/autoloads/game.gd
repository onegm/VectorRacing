extends Node

const TILE_SIZE = 22
enum INPUT_METHOD {KEYBOARD, MOUSE}
enum VECTOR_MODE {TAIL_TO_TAIL, HEAD_TO_TAIL}

var vector_mode : VECTOR_MODE = VECTOR_MODE.TAIL_TO_TAIL
var input_method : INPUT_METHOD = INPUT_METHOD.KEYBOARD
var num_players = 3

var current_track = 1
var camera_limit_rect : Rect2

@onready var race_manager : PackedScene = load("res://entities/levels/race_manager.tscn")
@onready var main_menu_address = "res://entities/ui/start_page/start_page.tscn"
@onready var instructions_scene_address = "res://entities/ui/instructions/instructions.tscn"

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
	input_method = mode
	SignalBus.input_method_changed.emit()

func set_current_track(track : int):
	current_track = track
	SignalBus.track_changed.emit()
	#race_manager = load("res://entities/levels/race_manager.tscn")
	#race_manager.set_track(index)
	
func set_camera_limit_rect(rect : Rect2):
	camera_limit_rect = rect
	SignalBus.camera_limit_rect_changed.emit(camera_limit_rect)
	
func get_main_menu_scene() -> PackedScene:
	return load(main_menu_address)

func get_instructions_scene() -> PackedScene:
	return load(instructions_scene_address)

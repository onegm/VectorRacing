extends Node

const TILE_SIZE = 22
enum INPUT_METHOD {KEYBOARD, MOUSE}
enum VECTOR_MODE {TAIL_TO_TAIL, HEAD_TO_TAIL}
enum TRACK {SPRING, SUMMER, WINTER}

var vector_mode : VECTOR_MODE = VECTOR_MODE.TAIL_TO_TAIL:
	set(mode): vector_mode = clamp(mode, 0, VECTOR_MODE.size() - 1)
		
var input_method : INPUT_METHOD = INPUT_METHOD.KEYBOARD:
	set(method): input_method = clamp(method, 0, INPUT_METHOD.size()-1)

var num_players : int = 3:
	set(num): num_players = clamp(num, 1, 3) 

var current_track : TRACK = TRACK.SPRING :
	set(track):
		current_track = clamp(track, 0, TRACK.size()-1)
		SignalBus.track_changed.emit()

@onready var race_manager : PackedScene = preload("res://entities/race_manager/race_manager.tscn")
var main_menu_address = "res://ui/start_page/start_page.tscn"
var instructions_scene_address = "res://ui/instructions/instructions.tscn"
var leaderboard_scene_address = "res://ui/leaderboard/Leaderboard.tscn"

func _ready() -> void:
	config()
	
func config():
	SilentWolf.configure({
		"api_key": Private.api_key,
		"game_id": Private.game_identifier,
		"log_level": 0
	})

func toggle_vector_mode():
	vector_mode = wrap(vector_mode + 1, 0, 1)
	
func get_main_menu_scene() -> PackedScene:
	return load(main_menu_address)

func get_instructions_scene() -> PackedScene:
	return load(instructions_scene_address)

func get_leaderboard_scene() -> PackedScene:
	return load(leaderboard_scene_address)

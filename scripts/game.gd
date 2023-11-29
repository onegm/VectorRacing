extends Node

const TILE_SIZE = 22
enum INPUT_METHOD {KEYBOARD, MOUSE}
enum VECTOR_MODE {TAIL_TO_TAIL, HEAD_TO_TAIL}

var vector_mode : VECTOR_MODE = VECTOR_MODE.TAIL_TO_TAIL
var num_of_players = 2
var input_mode : INPUT_METHOD = INPUT_METHOD.KEYBOARD


func set_num_players(num : int):
	num_of_players = num
	print(num)
	
func set_vector_mode(mode : VECTOR_MODE):
	vector_mode = mode

func set_input_method(mode : INPUT_METHOD):
	input_mode = mode

extends Node

const TILE_SIZE = 22.0
var tail_to_tail_mode = true
var num_of_players = 2
var input_mode = true
var current_level : PackedScene

@onready var main_menu : PackedScene = load("res://scenes/start_page.tscn")

func set_num_players(num : int):
	num_of_players = num
	print(num)
	
func set_tail_to_tail_mode(mode : bool):
	tail_to_tail_mode = mode
	print(mode)

func set_input_mode(mode : bool):
	input_mode = mode

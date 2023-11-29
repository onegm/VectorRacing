extends Node2D

@onready var vector_mode_button = $Control/VectorModeButton
@onready var num_players_button = $Control/NumPlayersButton
@onready var start_button = $Control/StartButton
@onready var input_method_button = $Control/InputMethodButton

@export var level : PackedScene = null

func _ready():
	vector_mode_button.item_selected.connect(on_vector_mode_selected)
	num_players_button.item_selected.connect(on_num_players_selected)
	input_method_button.item_selected.connect(on_input_method_selected)
	start_button.pressed.connect(on_start_button_pressed)

func on_vector_mode_selected(mode_idx):
	if(mode_idx == 0):
		Game.set_vector_mode(Game.VECTOR_MODE.TAIL_TO_TAIL)
	elif mode_idx == 1:
		Game.set_vector_mode(Game.VECTOR_MODE.HEAD_TO_TAIL)
	else:
		push_error("Invalid vector mode selected")
		

func on_num_players_selected(index):
	Game.set_num_players(index+1)

func on_input_method_selected(method_idx):
	if method_idx == 0:
		Game.set_input_method(Game.INPUT_METHOD.KEYBOARD)
	elif method_idx == 1:
		Game.set_input_method(Game.INPUT_METHOD.MOUSE)
	else:
		push_error("Invalid input method selected")

func on_start_button_pressed():
	get_tree().change_scene_to_packed(level)
	pass

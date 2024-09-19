extends Control

@onready var vector_mode_button : OptionButton = $VectorModeButton
@onready var num_players_button : OptionButton = $NumPlayersButton
@onready var input_method_button : OptionButton = $InputMethodButton
@onready var track_button : OptionButton = $LevelButton

@onready var vector_modes = ["Tail to tail", "Head to tail"]
@onready var num_players = ["One Player", "Two Players", "Three Players"]
@onready var input_methods = ["Keyboard", "Mouse"]
@onready var button_options = {
	vector_mode_button : vector_modes,
	num_players_button : num_players,
	input_method_button : input_methods
}

func _ready():
	connect_signals()
	for button in button_options:
		for option in button_options[button]:
			button.add_item(option)
	set_defaults()
	
func set_defaults():
	vector_mode_button.select(Game.vector_mode)
	num_players_button.select(Game.num_players - 1)
	input_method_button.select(Game.input_method)
	track_button.select(Game.current_track)
	

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

func on_level_selected(index : int):
	Game.set_current_track(index)

func on_start_button_pressed():
	get_tree().change_scene_to_packed(Game.race_manager)

func on_help_button_pressed():
	get_tree().change_scene_to_packed(Game.get_instructions_scene())

func on_leaderboard_button_pressed():
	get_tree().change_scene_to_packed(Game.get_leaderboard_scene())
	
func connect_signals():
	vector_mode_button.item_selected.connect(on_vector_mode_selected)
	num_players_button.item_selected.connect(on_num_players_selected)
	input_method_button.item_selected.connect(on_input_method_selected)
	track_button.item_selected.connect(on_level_selected)
	%StartButton.pressed.connect(on_start_button_pressed)
	%HelpButton.pressed.connect(on_help_button_pressed)
	%LeaderboardButton.pressed.connect(on_leaderboard_button_pressed)

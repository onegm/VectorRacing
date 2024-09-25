extends Control

@onready var vector_mode_button : OptionButton = $VectorModeButton
@onready var num_players_button : OptionButton = $NumPlayersButton
@onready var input_method_button : OptionButton = $InputMethodButton
@onready var track_button : OptionButton = $TrackButton

@onready var num_players = ["One Player", "Two Players", "Three Players"]
@onready var input_methods = ["Keyboard", "Mouse"]
@onready var button_options = {
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

func on_start_button_pressed():
	get_tree().change_scene_to_packed(Game.race_manager)

func on_help_button_pressed():
	get_tree().change_scene_to_packed(Game.get_instructions_scene())

func on_leaderboard_button_pressed():
	get_tree().change_scene_to_packed(Game.get_leaderboard_scene())
	
func connect_signals():
	num_players_button.item_selected.connect(func(index): Game.num_players = index + 1)
	track_button.item_selected.connect(func(index): Game.current_track = index)
	vector_mode_button.item_selected.connect(func(index): Game.vector_mode = index)
	input_method_button.item_selected.connect(func(index): Game.input_method = index)
	%StartButton.pressed.connect(on_start_button_pressed)
	%HelpButton.pressed.connect(on_help_button_pressed)
	%LeaderboardButton.pressed.connect(on_leaderboard_button_pressed)

extends Control

@onready var replayButton = $Panel/ReplayButton
@onready var menuButton = $Panel/MenuButton
@onready var win_label = $Panel/Label

func _ready():
	replayButton.pressed.connect(on_replay_pressed)
	menuButton.pressed.connect(on_menu_pressed)

func on_replay_pressed():
	get_tree().change_scene_to_packed(Game.current_level)

func on_menu_pressed():
	get_tree().change_scene_to_packed(Game.main_menu)
	
func set_winner(winner : Racer):
	if winner != null:
		win_label.set_text(winner.name + " Wins!!")
	else:
		win_label.set_text("It's a tie!!")

extends Node2D

@onready var tail_mode_button = $Control/TailToTailButton
@onready var num_players_button = $Control/NumPlayersButton
@onready var start_button = $Control/StartButton

@export var level : PackedScene = null

func _ready():
	tail_mode_button.toggled.connect(on_tail_mode_toggled)
	num_players_button.item_selected.connect(on_num_players_selected)
	start_button.pressed.connect(on_start_button_pressed)
	

func on_tail_mode_toggled(mode):
	Game.set_tail_to_tail_mode(mode)

func on_num_players_selected(index):
	Game.set_num_players(index+1)


func on_start_button_pressed():
	get_tree().change_scene_to_packed(level)
	pass

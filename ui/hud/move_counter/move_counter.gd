extends Control

@onready var moves_label = $MovesLabel
var player : CharacterBody2D
var on_turn_color = Color.GREEN
var out_of_turn_color = Color.WHITE
var finished_color = Color.GOLDENROD


func set_player(new_player : CharacterBody2D):
	player = new_player
	player.moves_changed.connect(update_player_label)
	player.turn_started.connect(on_turn_start)
	player.turn_ended.connect(on_turn_end)
	player.finished.connect(on_player_finished)
	update_player_label()

func update_player_label():
	moves_label.set_text(player.get_name() + ": " + str(player.get_moves()))
	
func on_turn_start():
	moves_label.set_modulate(on_turn_color)

func on_turn_end():
	moves_label.set_modulate(out_of_turn_color)

func on_player_finished():
	moves_label.set_modulate(finished_color)

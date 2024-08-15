extends Control

@onready var replayButton = $Panel/ReplayButton
@onready var menuButton = $Panel/MenuButton
@onready var win_label = $Panel/Label

func _ready():
	replayButton.pressed.connect(on_replay_pressed)
	menuButton.pressed.connect(on_menu_pressed)

func on_replay_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game.race_manager)

func on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game.get_main_menu_scene())
	
func set_winner(winners : Array):
	var text = ""
	if winners.size() > 1:
		text = "It's a tie between: "
		if winners.size() == 2:
			text += winners[0].name + " and " + winners[1].name
		else:
			for i in winners.size():
				text += winners[i].name
				if i < winners.size() - 2:
					text += ", "
				elif i < winners.size() - 1:
					text += ", and "
	elif winners.size() == 1:
		text = winners[0].name + " Wins!!"
	else:
		text = "No winners..."
		
	win_label.set_text(text)

func make_visible():
	set_visible(true)
	get_tree().paused = true

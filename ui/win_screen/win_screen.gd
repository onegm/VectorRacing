extends Control

@onready var play_again_button = $Panel/PlayAgainButton
@onready var menu_button = $Panel/MenuButton
@onready var watch_replay_button = $Panel/WatchReplayButton
@onready var win_label = $Panel/Label

func _ready():
	play_again_button.pressed.connect(on_play_again_pressed)
	menu_button.pressed.connect(on_menu_pressed)
	watch_replay_button.pressed.connect(on_watch_replay_pressed)
	
func on_play_again_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game.race_manager)

func on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game.get_main_menu_scene())

func on_watch_replay_pressed():
	set_visible(false)
	SignalBus.replay_started.emit()
	await SignalBus.replay_ended
	set_visible(true)

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

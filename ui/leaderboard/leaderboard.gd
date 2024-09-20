extends Control

@onready var leaderboards = [%SPRING, %SUMMER, %WINTER]

func _ready() -> void:
	update()
	$BackButton.pressed.connect(get_tree().change_scene_to_packed.bind(Game.get_main_menu_scene()))

func update():	
	for track in Game.TRACK.values():
		var track_leaderboard = await LeaderboardManager.get_sorted_track_leaderboard(track)
		var place_labels : Array = leaderboards[track].get_children()
		var index = 0
		for child : Label in place_labels:
			if index >= track_leaderboard.size():
				break
			child.text = track_leaderboard[index].name + " : " + str(track_leaderboard[index].moves)
			index += 1

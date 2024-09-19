extends Control

@onready var leaderboards = [%SPRING, %SUMMER, %WINTER]
const max_char := 5

func _ready() -> void:
	update()

func update():	
	for track in Game.TRACK.values():
		var track_leaderboard = LeaderboardManager.get_sorted_track_leaderboard(track)
		var place_labels : Array = leaderboards[track].get_children()
		var index = 0
		for child : Label in place_labels:
			child.text = track_leaderboard[index].name.erase(max_char, max_char ** 10) + " : " + str(track_leaderboard[index].moves)
			index += 1

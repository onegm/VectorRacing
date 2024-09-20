extends Node

const LEADERBOARD_LIMIT := 5

func gets_on_leaderboard(track : Game.TRACK , moves : int) -> bool:
	var track_leaderboard = await get_sorted_track_leaderboard(track)
	if track_leaderboard.size() < LEADERBOARD_LIMIT: return true
	for player in track_leaderboard:
		if moves < player.moves:
			return true
	return false

func save_score(player_name : String, score : int, board_name : String = "main"):
	SilentWolf.Scores.save_score(player_name, score, board_name)

func get_sorted_track_leaderboard(track : Game.TRACK) -> Array:
	var leaderboard : Dictionary = await SilentWolf.Scores.get_scores(5).sw_get_scores_complete
	var leaderboard_arr : Array = []
	for player in leaderboard.scores:
		leaderboard_arr.append({
			"moves" : player.score, 
			"name" : player.player_name
		})
	return leaderboard_arr

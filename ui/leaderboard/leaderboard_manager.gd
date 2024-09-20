extends Node

const LEADERBOARD_LIMIT := 5

func gets_on_leaderboard(track : Game.TRACK , moves : int) -> bool:
	var track_leaderboard = await get_sorted_track_leaderboard(track)
	if track_leaderboard.size() < LEADERBOARD_LIMIT: return true
	for player in track_leaderboard:
		if moves < player.moves:
			return true
	return false

func save_score(player_name : String, score : int, track : Game.TRACK):
	var leaderboard_name = Game.TRACK.keys()[track]
	var track_leaderboard = await get_sorted_track_leaderboard(track)
	if track_leaderboard.size() < LEADERBOARD_LIMIT:
		SilentWolf.Scores.save_score(player_name, score, leaderboard_name)
		return
	track_leaderboard.pop_back()
	track_leaderboard.append({"moves" : score, "name" : player_name})
	SilentWolf.Scores.wipe_leaderboard(leaderboard_name)
	for player in track_leaderboard:
		SilentWolf.Scores.save_score(player.name, player.moves, leaderboard_name)

func get_sorted_track_leaderboard(track : Game.TRACK) -> Array:
	var leaderboard_name = Game.TRACK.keys()[track]
	var leaderboard : Dictionary = await SilentWolf.Scores.get_scores(5, leaderboard_name).sw_get_scores_complete
	var leaderboard_arr : Array = []
	for player in leaderboard.scores:
		leaderboard_arr.append({
			"moves" : player.score, 
			"name" : player.player_name
		})
	leaderboard_arr.reverse()
	return leaderboard_arr

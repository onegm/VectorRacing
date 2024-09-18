extends Node

const file_path := "res://leaderboard/leaderboard.json"

func read_data():
	if not FileAccess.file_exists(file_path):
		printerr(file_path + " does not exist.")
		return 
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	var data : Dictionary = JSON.parse_string(content)
	file.close()
	return data
	
func gets_on_leaderboard(track : Game.TRACK , moves : int) -> bool:
	var track_leaderboard = read_data()[Game.TRACK.keys()[track]]
	for key in track_leaderboard:
		var record = track_leaderboard[key]["moves"]
		if record == null or record > moves :
			return true
	return false

func place_in_leaderboard(track : Game.TRACK , player_name : String, moves : int):
	var new_player = {"moves" : moves, "name" : player_name}
	var track_leaderboard = get_sorted_track_leaderboard(track)
	track_leaderboard.append(new_player)
	track_leaderboard.sort_custom(sort_by_moves)
	track_leaderboard.pop_back()
	update_leaderboard(track, track_leaderboard)

func get_sorted_track_leaderboard(track : Game.TRACK) -> Array:
	var track_leaderboard = read_data()[Game.TRACK.keys()[track]]
	var leaderboard_arr = []
	for key in track_leaderboard:
		leaderboard_arr.append(track_leaderboard[key])
	leaderboard_arr.sort_custom(sort_by_moves)
	return leaderboard_arr

func sort_by_moves(a, b):
	if a.moves == null and b.moves != null:
		return false
	if b.moves == null:
		return true
	return a.moves < b.moves

func update_leaderboard(track : Game.TRACK, track_leaderboard : Array):
	var leaderboard = read_data()
	var index = 0
	for key in leaderboard[Game.TRACK.keys()[track]]:
		leaderboard[Game.TRACK.keys()[track]][key] = track_leaderboard[index]
		index += 1
		
	var json_string = JSON.stringify(leaderboard, "\t")
	write_data(json_string)

func write_data(data : String):
	if not FileAccess.file_exists(file_path):
		printerr(file_path + " does not exist.")
		return 
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(data)
	file.close()

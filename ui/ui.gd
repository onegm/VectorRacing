extends CanvasLayer

@onready var win_screen = $WinScreen
@onready var pause_menu: Control = $PauseMenu
@onready var leaderboard_entry = $LeaderboardEntry

func _ready():
	SignalBus.race_ended.connect(on_race_ended)
	SignalBus.pause_pressed.connect(pause_menu.toggle_visibility)

func on_race_ended(winners : Array, finishers : Array):
	win_screen.set_winner(winners)
	win_screen.make_visible()
	
	check_for_new_records(finishers)

func check_for_new_records(finishers : Array):
	finishers.sort_custom(func(a, b): return a.moves < b.moves)
	for finisher in finishers:
		var new_record = await LeaderboardManager.gets_on_leaderboard(Game.current_track, finisher.moves)
		if !new_record:
			return
		leaderboard_entry.set_player(finisher)
		leaderboard_entry.visible = true
		await SignalBus.leaderboard_score_submitted

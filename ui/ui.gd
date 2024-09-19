extends CanvasLayer

@onready var win_screen = $WinScreen
@onready var pause_menu: Control = $PauseMenu
@onready var leaderboard_entry = $LeaderboardEntry

func _ready():
	SignalBus.race_ended.connect(on_race_ended)
	SignalBus.pause_pressed.connect(on_pause_pressed)

func on_race_ended(winners : Array, finishers : Array):
	win_screen.set_winner(winners)
	win_screen.make_visible()
	
	check_for_new_records(finishers)

func on_pause_pressed() -> void:
	pause_menu.toggle_visibility()

func check_for_new_records(finishers : Array):
	finishers.sort_custom(LeaderboardManager.sort_by_moves)
	print(finishers)
	for finisher in finishers:
		if !LeaderboardManager.gets_on_leaderboard(Game.current_track, finisher.moves):
			return
		leaderboard_entry.set_player(finisher)
		leaderboard_entry.visible = true
		await SignalBus.leaderboard_updated
		print("Leaderboard updated!")
		leaderboard_entry.visible = false

extends CanvasLayer

@onready var win_screen = $WinScreen
@onready var pause_menu: Control = $PauseMenu

func _ready():
	SignalBus.race_ended.connect(on_race_ended)
	SignalBus.pause_pressed.connect(on_pause_pressed)

func on_race_ended(winners : Array):
	win_screen.set_winner(winners)
	win_screen.make_visible()

func on_pause_pressed() -> void:
	pause_menu.toggle_visibility()

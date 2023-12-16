extends CanvasLayer

@onready var win_screen = $WinScreen

func _ready():
	SignalBus.race_ended.connect(on_race_ended)

func on_race_ended(winners : Array):
	win_screen.set_winner(winners)
	win_screen.visible = true


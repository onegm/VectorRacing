extends Control

@onready var vehicle = %Vehicle
@onready var text_edit : TextEdit = %TextEdit
@onready var submit_button := %SubmitButton

const max_char := 5
var player : CharacterBody2D = null

func _ready() -> void:
	text_edit.text_changed.connect(on_text_changed)
	submit_button.pressed.connect(on_submit_pressed)
	
func set_player(new_player : CharacterBody2D) -> void:
	player = new_player
	vehicle.modulate = player.vehicle_color
	%MovesLabel.text = str(player.moves)

func _process(delta: float) -> void:
	vehicle.rotate(0.5*delta)

func on_text_changed():
	if text_edit.text.length() < max_char:
		return
	text_edit.text = text_edit.text.erase(max_char, max_char ** 10)
	text_edit.set_caret_column(max_char)

func on_submit_pressed():
	LeaderboardManager.save_score(text_edit.text, player.moves)
	text_edit.clear()
	visible = false
	SignalBus.leaderboard_score_submitted.emit()

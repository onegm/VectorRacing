extends Control

func _ready() -> void:
	%MinimizeButton.pressed.connect(func(): %LegendScreen.visible = false)
	$MaximizeButton.pressed.connect(func(): %LegendScreen.visible = true)
	if Game.vector_mode == Game.VECTOR_MODE.TAIL_TO_TAIL:
		%VfBox.visible = false

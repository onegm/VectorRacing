extends Control

@onready var restart_button: Button = %ReplayButton
@onready var menu_button: Button = %MenuButton
@onready var continue_button: Button = %ContinueButton

func _ready():
	restart_button.pressed.connect(on_restart_pressed)
	menu_button.pressed.connect(on_menu_pressed)
	continue_button.pressed.connect(toggle_visibility)
	
func on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game.race_manager)

func on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(Game.get_main_menu_scene())

func toggle_visibility():
	set_visible(!visible)
	get_tree().paused = visible

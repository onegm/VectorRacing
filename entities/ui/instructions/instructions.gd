extends Control

func _ready():
	$MainMenu.pressed.connect(on_button_pressed)

func on_button_pressed():
	get_tree().change_scene_to_packed(Game.get_main_menu_scene())

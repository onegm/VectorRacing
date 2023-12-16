extends Area2D

func _ready():
	body_entered.connect(toggle_vector_mode)
	
func toggle_vector_mode(_body):
	Game.toggle_vector_mode()

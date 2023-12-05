extends Control

@onready var moves_label = $MovesLabel
var racer : Racer

func _ready():
	update_label()
		
func set_racer(new_racer : Racer):
	racer = new_racer
	racer.started_moving.connect(update_label)
	racer.crashed.connect(update_label)
	racer.my_turn.connect(on_my_turn)
	racer.not_my_turn.connect(on_not_my_turn)
	

func update_label(_velocity = Vector2.ZERO):
	moves_label.set_text(racer.name + ": " + str(racer.get_moves()))

func on_my_turn():
	moves_label.modulate = Color.GOLD

func on_not_my_turn():
	moves_label.set_modulate(Color.WHITE)

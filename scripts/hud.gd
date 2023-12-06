extends Control

@onready var moves_label = $MovesLabel
var racer : Racer

func _ready():
	update_label()
		
func set_racer(new_racer : Racer):
	racer = new_racer
	racer.started_moving.connect(update_label)
	racer.crashed.connect(update_label)
	racer.my_turn_started.connect(on_my_turn_started)
	racer.my_turn_ended.connect(on_my_turn_ended)
	racer.resetted.connect(update_label)
	

func update_label(_velocity = Vector2.ZERO):
	moves_label.set_text(racer.name + ": " + str(racer.get_moves()))

func on_my_turn_started():
	moves_label.modulate = Color.GOLD

func on_my_turn_ended():
	moves_label.set_modulate(Color.WHITE)

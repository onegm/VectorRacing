extends Control

@onready var moves_label = $MovesLabel
var racer : Racer
var on_turn_color = Color.GREEN
var out_of_turn_color = Color.WHITE
var finished_color = Color.GOLDENROD

func _ready():
	update_label()
		
func set_racer(new_racer : Racer):
	racer = new_racer
	racer.started_moving.connect(update_label)
	racer.crashed.connect(update_label)
	racer.my_turn_started.connect(on_turn_start)
	racer.my_turn_ended.connect(on_turn_end)
	racer.resetted.connect(update_label)
	racer.finished.connect(on_racer_finished)
	

func update_label(_velocity = Vector2.ZERO):
	moves_label.set_text(racer.name + ": " + str(racer.get_moves()))

func on_turn_start():
	moves_label.set_modulate(on_turn_color)

func on_turn_end():
	moves_label.set_modulate(out_of_turn_color)

func on_racer_finished():
	moves_label.set_modulate(finished_color)


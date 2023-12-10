extends Camera2D

var racers : Array

func _process(_delta):
#	update_position()
	pass

func follow(new_racers : Array):
	racers = new_racers
	update_position()

func update_position():
	var avg_position = Vector2.ZERO
	
	for racer in racers:
		avg_position += racer.global_position
	
	avg_position /= racers.size()
	
	global_position = avg_position

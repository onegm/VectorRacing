extends Camera2D

var racers : Array
var rand = RandomNumberGenerator.new()
var current_shake_strength : float = 0.0

const SHAKE_STRENGTH : float = Game.TILE_SIZE / 5.0
const SHAKE_DECAY : float = 10.0

func _ready():
	rand.randomize()
	RacerSignalBus.crashed.connect(shake)

func _process(delta):
	update_position()
	if current_shake_strength > 1e-5:
		current_shake_strength = lerp(current_shake_strength, 0.0, SHAKE_DECAY*delta)
		set_offset(get_shake_offset())

func follow(new_racers : Array):
	racers = new_racers
	update_position()

func update_position():
	var avg_position = Vector2.ZERO
	for racer in racers:
		avg_position += racer.global_position
	avg_position /= racers.size()
	global_position = avg_position

func shake(_racer):
	current_shake_strength = SHAKE_STRENGTH

func get_shake_offset():
	return Vector2(
		rand.randfn(0, current_shake_strength),
		rand.randfn(0, current_shake_strength)		
	)

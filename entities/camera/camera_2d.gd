extends Camera2D

var players : Array
var rand = RandomNumberGenerator.new()
var current_shake_strength : float = 0.0

const SHAKE_STRENGTH : float = Game.TILE_SIZE / 5.0
const SHAKE_DECAY : float = 10.0

@onready var shake_disabled := false

func _ready():
	rand.randomize()
	SignalBus.player_crashed.connect(shake)
	SignalBus.race_ended.connect(on_race_ended)

func _process(delta):
	update_position()
	if current_shake_strength > 1e-5:
		current_shake_strength = lerp(current_shake_strength, 0.0, SHAKE_DECAY*delta)
		set_offset(get_shake_offset())

func follow(new_players : Array):
	if new_players.is_empty() or new_players == null : return
	players = new_players
	update_position()

func update_position():
	if players.is_empty() or players == null : return
	var avg_position = Vector2.ZERO
	for player in players:
		avg_position += player.global_position
	avg_position /= players.size()
	global_position = avg_position
		
func shake():
	if shake_disabled:
		return
	current_shake_strength = SHAKE_STRENGTH

func get_shake_offset():
	return Vector2(
		rand.randfn(0, current_shake_strength),
		rand.randfn(0, current_shake_strength)		
	)

func on_race_ended(_winners, _finishers):
	shake_disabled = true

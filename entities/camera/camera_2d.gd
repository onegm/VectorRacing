extends Camera2D

var players : Array
var rand = RandomNumberGenerator.new()
var current_shake_strength : float = 0.0

const SHAKE_STRENGTH : float = Game.TILE_SIZE / 5.0
const SHAKE_DECAY : float = 10.0

func _ready():
	rand.randomize()
	SignalBus.player_crashed.connect(shake)
	SignalBus.camera_limit_rect_changed.connect(set_rect_limits)
	set_rect_limits(Game.camera_limit_rect)

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
	current_shake_strength = SHAKE_STRENGTH

func get_shake_offset():
	return Vector2(
		rand.randfn(0, current_shake_strength),
		rand.randfn(0, current_shake_strength)		
	)

func set_rect_limits(rect : Rect2):
	limit_left = rect.position.x as int
	limit_right = rect.position.x + rect.size.x as int
	limit_top = rect.position.y as int
	limit_bottom = rect.position.y + rect.size.y as int

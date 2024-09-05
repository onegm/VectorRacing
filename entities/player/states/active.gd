extends State
class_name ActiveState

@export
var moving_state: State

func process_input(_event: InputEvent) -> State:
	var acceleration = InputManager.process_player_input(parent.global_position).normalized()*Game.TILE_SIZE
	parent.set_acceleration(acceleration)
	
	if InputManager.process_confirmation():
		return moving_state
	return null

func exit():
	parent.update_velocity()
	InputManager.reset()

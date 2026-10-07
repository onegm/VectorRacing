class_name ReplayTimer extends Timer


func _ready() -> void:
	timeout.connect(SignalBus.update_replay_velocity.emit)
	one_shot = false
	wait_time = 1.0

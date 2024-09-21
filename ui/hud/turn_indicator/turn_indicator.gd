extends Node2D

var player : CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	SignalBus.race_ended.connect(on_race_ended)

func set_player(new_player : CharacterBody2D):
	player = new_player
	player.turn_started.connect(on_turn_started)
	player.turn_ended.connect(on_turn_ended)
	player.add_sibling(self)
	global_position = player.global_position
	
	var remote_transform = RemoteTransform2D.new()
	remote_transform.update_rotation = false
	remote_transform.remote_path = self.get_path()
	player.add_child(remote_transform)

func on_turn_started() -> void:
	visible = true
	animation_player.play("active")

func on_turn_ended() -> void:
	visible = false
	animation_player.stop(false)

func on_race_ended(_winners, _finishers):
	on_turn_ended()

extends RaceManager
class_name ChallengeManager

@export var challenge_scene : PackedScene = preload("res://entities/challenges/stop_challenge.tscn")

func _ready():
	Game.num_players = 1
	track = challenge_scene.instantiate()
	super()

extends RaceManager
class_name ChallengeManager

@onready var challenge_scene : PackedScene = load("res://entities/challenges/challenge_" + str(Game.current_challenge) + ".tscn")

func _ready():
	Game.num_players = 1
	track = challenge_scene.instantiate()
	super()

extends Node

@onready var engine_sound : AudioStreamPlayer = $EngineSound
@onready var crash_sound : AudioStreamPlayer = $CrashSound
@onready var applause_sound : AudioStreamPlayer = $ApplauseSound
@onready var crowd_ambience : AudioStreamPlayer = $CrowdAmbience
@onready var theme_music : AudioStreamPlayer = $ThemeMusic

func _ready():
	SignalBus.race_loaded.connect(on_race_loaded)
	SignalBus.race_unloaded.connect(on_race_unloaded)
	
func on_race_loaded():
	for sound in get_children():
		sound.stop()
	crowd_ambience.play()	
	
func on_race_unloaded():
	for sound in get_children():
		sound.stop()
	theme_music.play()

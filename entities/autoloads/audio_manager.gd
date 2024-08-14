extends Node

@onready var engine_sound : AudioStreamPlayer = $EngineSound
@onready var crash_sound : AudioStreamPlayer = $CrashSound
@onready var applause_sound : AudioStreamPlayer = $ApplauseSound
@onready var background_music : AudioStreamPlayer = $BackgroundMusic

func _ready():
	SignalBus.race_loaded.connect(on_race_loaded)
	SignalBus.race_unloaded.connect(on_race_loaded)
	
func on_race_loaded():
	for sound in get_children():
		sound.stop()

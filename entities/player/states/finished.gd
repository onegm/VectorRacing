extends State
class_name FinishedState

func enter():
	super.enter()
	AudioManager.applause_sound.play()

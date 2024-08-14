extends State
class_name FinishedState

func enter():
	super()
	AudioManager.applause_sound.play()
	parent.finished.emit()

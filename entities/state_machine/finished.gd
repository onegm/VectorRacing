extends State
class_name FinishedState

func enter():
	super()
	parent.finished.emit()

extends Level

var text_array : Array

func _ready():
	super._ready()
	var tutorial_text = get_tree().current_scene.get_node("Track0").get_node("TutorialText")
	for label_node in tutorial_text.get_children():
		text_array.append(label_node)
	update_text_visibility()
	update_camera_position()

func _process(delta):
	super._process(delta)
	update_text_visibility()
	update_camera_position()
	
func get_distance_from_racer(node):
	return (node.global_position - current_racer.global_position).length()

func update_text_visibility():
	for text_label in text_array:
		var distance = get_distance_from_racer(text_label)
		var a = 1 - distance / 500
		text_label.modulate.a = a

func update_camera_position():
	if current_racer.global_position.x > 1154:
		camera.global_position.x = 1152.0*3/2
	else:
		camera.global_position.x = 1152.0/2
	
	if current_racer.global_position.y > 650:
		camera.global_position.y = 648.0*3/2
	else:
		camera.global_position.y = 648.0/2

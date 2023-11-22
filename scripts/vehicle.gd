extends CharacterBody2D
class_name Vehicle

@onready var sprite = $Sprite2D

var target_position = global_position
var active = false

func _physics_process(delta):
	var distance_from_target = (target_position - global_position).length()
	if active:
		global_position += velocity*delta
		if distance_from_target < 5:
			global_position = target_position
			active = false

func move_to_target(new_target_position : Vector2):
	target_position = new_target_position
	velocity = target_position - global_position
	active = true
	
func is_active():
	return active

func set_color(color : Color):
	sprite.set_modulate(color)
	

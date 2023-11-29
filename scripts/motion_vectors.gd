extends Node2D

var velocity : Vector2 = Vector2.ZERO
var acceleration : Vector2 = Vector2.ZERO

const ARROW_HEAD_SCALE = Game.TILE_SIZE / 5.0

@onready var vector_mode = Game.vector_mode 

func set_new_velocity(new_velocity : Vector2):
	velocity = new_velocity
	acceleration = Vector2.ZERO
	queue_redraw()

func set_new_acceleration(new_acceleration : Vector2):
	acceleration = new_acceleration
	queue_redraw()

func _draw():
	redraw_vector(velocity, Color.WHITE)
	
	var offset = Vector2.ZERO
	if vector_mode == Game.VECTOR_MODE.HEAD_TO_TAIL:
		offset = velocity
	redraw_vector(acceleration, Color.CORAL, offset)

	
func redraw_vector(end : Vector2, color : Color, offset : Vector2 = Vector2.ZERO):
	var arrow_head = PackedVector2Array()
	var arrow_head_vector = end - end.normalized()*ARROW_HEAD_SCALE
	var arrow_head_rotation_angle = 2*PI/end.length()
	var head_point2 = (arrow_head_vector).rotated(arrow_head_rotation_angle)
	var head_point3 = (arrow_head_vector).rotated(-arrow_head_rotation_angle)
	arrow_head.append(end + offset)
	arrow_head.append(head_point2 + offset)
	arrow_head.append(head_point3 + offset)
	
	draw_line(offset, end + offset, color, 4.0)
	draw_colored_polygon(arrow_head, color)
	
func reset():
	set_new_velocity(Vector2.ZERO)
	set_new_acceleration(Vector2.ZERO)

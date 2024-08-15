extends Node2D

var player : CharacterBody2D
var velocity : Vector2 = Vector2.ZERO
var acceleration : Vector2 = Vector2.ZERO

var velocity_color = Color.WHITE
var acceleration_color = Color.CORAL

const ARROW_HEAD_SCALE = Game.TILE_SIZE / 5.0

@onready var vector_mode = Game.vector_mode

func _ready():
	SignalBus.vector_mode_changed.connect(func(): vector_mode = Game.vector_mode)
	
func set_player(new_player : CharacterBody2D):
	player = new_player
	player.acceleration_changed.connect(on_acceleration_changed)
	player.turn_started.connect(on_turn_started)
	player.turn_ended.connect(on_turn_ended)
	player.add_sibling(self)
	
	var remote_transform = RemoteTransform2D.new()
	remote_transform.update_rotation = false
	remote_transform.remote_path = self.get_path()
	player.add_child(remote_transform)

func on_turn_started(): set_visible(true)
func on_turn_ended(): set_visible(false)

func on_acceleration_changed():
	set_new_velocity(player.velocity)
	set_new_acceleration(player.acceleration)

func set_new_velocity(new_velocity : Vector2):
	velocity = new_velocity
	acceleration = Vector2.ZERO
	queue_redraw()

func set_new_acceleration(new_acceleration : Vector2):
	acceleration = new_acceleration
	queue_redraw()

func _draw():
	draw_vector(velocity, velocity_color)
	
	var offset = Vector2.ZERO
	if vector_mode == Game.VECTOR_MODE.HEAD_TO_TAIL:
		draw_vector(velocity + acceleration, Color.AQUA)
		offset = velocity
	draw_vector(acceleration, acceleration_color, offset)

	
func draw_vector(end : Vector2, color : Color, offset : Vector2 = Vector2.ZERO):
	var arrow_head = PackedVector2Array()
	
	var arrow_head_vector = end - end.normalized()*ARROW_HEAD_SCALE
	var arrow_head_rotation_angle = 2*PI/end.length()
	var head_point2 = (arrow_head_vector).rotated(arrow_head_rotation_angle)
	var head_point3 = (arrow_head_vector).rotated(-arrow_head_rotation_angle)
	arrow_head.append(end + offset)
	arrow_head.append(head_point2 + offset)
	arrow_head.append(head_point3 + offset)
	
	var arrow_head_length = end - head_point2.project(end)
	
	draw_line(offset, end + offset - arrow_head_length, color, 4.0)
	draw_colored_polygon(arrow_head, color)
	

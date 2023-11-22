extends Node2D

@onready var tile_size = Game.TILE_SIZE
@onready var anchor : Vector2 = global_position
@onready var previous_anchor_position : Vector2 = global_position
@onready var sprite = $TargetSprite

func update_position(dx:int, dy:int):
	global_position = anchor + Vector2(dx*tile_size, dy*tile_size)

func set_anchor(new_position : Vector2):
	previous_anchor_position = anchor
	anchor = new_position
	update_position(0, 0)

func get_anchor():
	return anchor

func set_color(color : Color):
	sprite.set_modulate(color)

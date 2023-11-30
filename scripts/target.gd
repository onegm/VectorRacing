extends Node2D

@onready var tile_size = Game.TILE_SIZE
@onready var target_sprite = $TargetSprite
@onready var anchor_sprite = $AnchorSprite

func update_target_position(new_position : Vector2):
	position = new_position
	target_sprite.position = new_position

func set_anchor(new_position : Vector2):
	position = new_position
	update_target_position(Vector2.ZERO)

func get_anchor():
	return position
	
func get_target():
	return target_sprite.global_position

func set_color(color : Color):
	target_sprite.set_modulate(color)
	anchor_sprite.set_modulate(Color.CORAL)

extends Node2D

@onready var player: CharacterBody2D = %player
@onready var sprite: AnimatedSprite2D = %player/sprite

const SPEED = 300

var direction: Vector2
var flip_x = false
var anim_direction: String = "down"

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	# movement
	var input_x = Input.get_axis("player_left", "player_right")
	var input_y = Input.get_axis("player_up", "player_down")
	var input_vector = Vector2(input_x, input_y).normalized()
	direction = input_vector
	
	player.velocity = input_vector * SPEED 
	player.move_and_slide()

	# animation
	var base_anim = "idle_" if direction == Vector2.ZERO else "walk_"

	if direction.y > 0:
		anim_direction = "down"
	elif direction.y < 0: 
		anim_direction = "up"
	elif direction.x < 0:
		anim_direction = "side"
		flip_x = true
	elif direction.x > 0:
		anim_direction = "side"
		flip_x = false
	
	var animation_name = base_anim + anim_direction
	sprite.play(animation_name)
	sprite.flip_h = flip_x
	

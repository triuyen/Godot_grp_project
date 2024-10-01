extends Node2D

@onready var player: CharacterBody2D = %player
@onready var sprite: AnimatedSprite2D = %player/sprite

# constants
const SPEED: int = 300
const MAX_HEALTH: int = 100

# stats 
var damage_amount: int = 20
var health: int = MAX_HEALTH

var direction: Vector2
var flip_x = false
var anim_direction: String = "down"

# attack variables
var is_attacking = false
var attack_animation_name: String = "attack_"
@onready var attack_hitbox: Area2D = $sword_area
var attack_offset = 8

# states variables
var is_alive = true



func _ready() -> void:
	attack_hitbox.monitoring = false
	pass

func _process(_delta: float) -> void:
	
	if not is_alive : return 
		
	# attack
	if Input.is_action_just_pressed("player_attack") and not is_attacking:
		is_attacking = true
		attack_hitbox.monitoring = true
		sprite.play(attack_animation_name + anim_direction)
		return 
	
	if is_attacking:
		if anim_direction == "up":
			attack_hitbox.position = Vector2(0, -attack_offset)
		elif anim_direction == "down":
			attack_hitbox.position = Vector2(0, attack_offset)
		elif anim_direction == "side":
			attack_hitbox.position = Vector2(attack_offset, 0) if not flip_x else Vector2(-attack_offset, 0)
			
		if not sprite.is_playing(): 
			is_attacking = false  
			attack_hitbox.monitoring = false
		else:
			return  

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


func _on_sword_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"): 
		print("Ennemi touché : ", body.name)
		#body.take_damage(damage_amount) 
	pass
	
func take_damage(amount: int) -> void:
	health -= amount
	#print("Damage taken : ", amount, "Current health : ", health)
	if health <= 0:
		health = 0
		player.is_alive = false
		player.die()
	pass
	
func die() -> void:
	sprite.play("death")
	pass

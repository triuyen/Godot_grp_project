extends CharacterBody2D

@onready var player: CharacterBody2D = self
@onready var sprite: AnimatedSprite2D = %sprite	

# constants
const SPEED: int = 300
const MAX_HEALTH: int = 100
const DASH_SPEED: int = 1000
const DASH_DURATION: float = 1

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

# dash
var is_dashing = false
var dash_timer = Timer

# states variables
var is_alive = true

func _ready() -> void:
	attack_hitbox.monitorable = false
	attack_hitbox.monitoring = false
	dash_timer = Timer.new()
	dash_timer.wait_time = DASH_DURATION
	dash_timer.one_shot = true
	add_child(dash_timer)
	dash_timer.connect("timeout", Callable(self, "_on_dash_finished"))
	pass

func _physics_process(_delta: float) -> void:
	
	if not is_alive : return 
	
	#if Input.is_action_just_pressed("take_damage_test"):
		#player.take_damage(20)
		#return 	
		
	# attack
	if Input.is_action_just_pressed("player_attack") and not is_attacking:
		is_attacking = true
		attack_hitbox.monitorable = true
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
			attack_hitbox.monitorable = false
			attack_hitbox.monitoring = false
		else:
			return  
	
	# dash
	#if Input.is_action_just_pressed("player_dash") and not is_dashing:
		#player.start_dash()
		#return
	#
	#if is_dashing:
		#return
	
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
	
func take_damage(amount: int) -> void:
	player.health -= amount
	player.health.clamp(health, 0, MAX_HEALTH)
	player.health_bar.value = health
	#print("Damage taken : ", amount, " | Current health : ", health)
	if player.health <= 0:
		player.die()
	pass
	
func die() -> void:		
	player.is_alive = false
	sprite.play("death")
	await get_tree().create_timer(2).timeout
	player.show_game_over()
	pass
	
func show_game_over() -> void: 
	print("*Show game over*")
	pass

#func start_dash() -> void:
	#is_dashing = true
	#var dash_direction = Vector2()
	#
	#if anim_direction == "down":
		#dash_direction = Vector2(0, 1)
	#elif anim_direction == "up": 
		#dash_direction = Vector2(0, -1)
	#elif anim_direction == "side" and flip_x == true :
		#dash_direction = Vector2(-1, 0)
	#else:
		#dash_direction = Vector2(1, 0)
		#
	#var tween = create_tween()
	#tween.tween_property(player, "position", dash_direction * DASH_SPEED, 0.5).as_relative()
	#dash_timer.start()
#
#func _on_dash_finished() -> void:
	#is_dashing = false
	#player.velocity =  Vector2.ZERO

extends CharacterBody2D

@onready var player: CharacterBody2D = self
@onready var sprite: AnimatedSprite2D = %sprite    
@onready var health_bar: ProgressBar = %health_bar
@onready var stamina_component: StaminaComponent = $stamina_component

# constants
const SPEED: int = 300
const DASH_SPEED: int = 1000
const DASH_DURATION: float = 1

# stats 
var damage_amount: int = 20

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
signal has_dashed

# states variables
var is_alive = true

func _ready() -> void:
	attack_hitbox.monitorable = false
	attack_hitbox.monitoring = false
	pass

func _process(_delta: float) -> void:
	
	if not is_alive : return 
		
	# attack
	if Input.is_action_just_pressed("player_attack") and not is_attacking:
		player.velocity =  Vector2.ZERO
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
	if Input.is_action_just_pressed("player_dash") and not is_dashing:
		player.start_dash()
		return
	
	if is_dashing:
		return
	
	# movement
	var input_x = Input.get_axis("player_left", "player_right")
	var input_y = Input.get_axis("player_up", "player_down")
	var input_vector = Vector2(input_x, input_y).normalized()
	direction = input_vector
	
	player.velocity = input_vector * SPEED

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

func _physics_process(delta: float) -> void:
	player.move_and_slide()
	
func die() -> void:		
	player.is_alive = false
	sprite.play("death")
	await get_tree().create_timer(2).timeout
	player.show_game_over()
	pass
	
func show_game_over() -> void: 
	print("*Show game over*")
	pass

func start_dash() -> void:
	
	if ask_for_stamina() == false:
		return
		
	is_dashing = true
	var dash_direction = Vector2()
	
	if anim_direction == "down":
		dash_direction = Vector2(0, 1)
	elif anim_direction == "up": 
		dash_direction = Vector2(0, -1)
	elif anim_direction == "side" and flip_x == true :
		dash_direction = Vector2(-1, 0)
	else:
		dash_direction = Vector2(1, 0)
	
	player.velocity = dash_direction * DASH_SPEED	
	await get_tree().create_timer(0.1).timeout
	_end_dash()
	

func _end_dash() -> void:
	is_dashing = false
	player.velocity =  Vector2.ZERO
	has_dashed.emit()
	
func ask_for_stamina() -> bool:
	if(stamina_component.stamina > 0):
		return true
	else:
		print("Vous n'avez pas assez de stamina.")
		return false

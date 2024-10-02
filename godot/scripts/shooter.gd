extends Node2D

@onready var ray_cast: RayCast2D = $RayCast2D
@export var projectile: PackedScene
@export var prediction_time: float = 1
@export var close_range: float = 200 

var can_see_player = true
var last_player_pos: Vector2
var player_velocity: Vector2

var player: CharacterBody2D

func _ready():
	player = get_tree().root.get_node("root2/player")
	if player:
		last_player_pos = player.global_position
	

func _physics_process(delta: float) -> void:
	_aim(delta)
	
	_check_player_collision()

func _aim(delta):
	var current_player_pos = player.global_position
	player_velocity = (current_player_pos - last_player_pos) / delta  
	last_player_pos = current_player_pos
	
	var distance_to_player = global_position.distance_to(current_player_pos)
	if distance_to_player < close_range:
		ray_cast.target_position = to_local(current_player_pos)
	else:
		var predicted_player_pos = current_player_pos + player_velocity * prediction_time
		ray_cast.target_position = to_local(predicted_player_pos)
	

func _check_player_collision():
	pass
	

func fire_projectile() -> void:
	print("SHOOT!")
	
	var current_projectile = projectile.instantiate()
	current_projectile.position = global_position
	current_projectile.direction = (ray_cast.target_position).normalized()
	get_tree().current_scene.add_child(current_projectile)

func _on_timer_timeout() -> void:
	if can_see_player:
		fire_projectile()

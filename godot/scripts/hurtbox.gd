extends Area2D

signal on_hit_taken(hit_position: Vector2)

@export var health: HealthComponent
@export var sprite: AnimatedSprite2D
@export var invincibility_timer: float = 1.0
@export var blink_duration: float = 0.3 

var can_be_hit = true

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and is_instance_valid(health):
		if not can_be_hit:
			return
		health.take_damage(area.damage)
		
		on_hit_taken.emit(area.global_position)
		
		if is_instance_valid(sprite):
			_start_blinking()
		
		if invincibility_timer:
			_start_invincibility()

func _start_invincibility() -> void:
	can_be_hit = false 
	set_deferred("monitoring", false)
	
	await get_tree().create_timer(invincibility_timer).timeout  
	
	can_be_hit = true 
	set_deferred("monitoring", true)
	

func _start_blinking() -> void:
	var blink_time = 0.0
	while blink_time < blink_duration:
		sprite.modulate = Color(10.0, 10.0, 10.0, 0.7)
		await get_tree().create_timer(0.05).timeout
		sprite.modulate = Color(1.0, 1.0, 1.0)
		await get_tree().create_timer(0.05).timeout
		blink_time += 0.1 

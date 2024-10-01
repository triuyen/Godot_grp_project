extends Area2D

signal on_hit_taken(hit_position: Vector2)

@export var health: HealthComponent
@export var invincibility_timer: float = 1.0

var can_be_hit = true

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and is_instance_valid(health):
		if not can_be_hit:
			return
		health.take_damage(area.damage)
		on_hit_taken.emit(area.global_position)
		if invincibility_timer:
			_start_invincibility()

func _start_invincibility() -> void:
	can_be_hit = false 
	set_deferred("monitoring", false)
	
	await get_tree().create_timer(invincibility_timer).timeout  
	
	can_be_hit = true 
	set_deferred("monitoring", true)
	

extends Area2D

signal hitbox_entered(hb: HitboxComponent)
@export var health: HealthComponent

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and is_instance_valid(health):
		health.take_damage(area.damage)

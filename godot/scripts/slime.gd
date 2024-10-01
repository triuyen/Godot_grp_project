extends  CharacterBody2D

var knockback_force = 300

func _process(delta: float) -> void:
	self.move_and_slide()
	

func _on_hit_taken(hit_position: Vector2) -> void:
	var hit_direction = (self.global_position - hit_position).normalized()
	self.velocity = hit_direction * knockback_force
	await get_tree().create_timer(0.2).timeout
	self.velocity = Vector2.ZERO

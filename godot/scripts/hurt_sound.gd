extends AudioStreamPlayer2D


func _on_hurtbox_coponent_on_hit_taken(hit_position: Vector2) -> void:
	self.play()

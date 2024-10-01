extends ProgressBar

func _on_health_component_health_updated(amount: int) -> void:
	self.value = amount

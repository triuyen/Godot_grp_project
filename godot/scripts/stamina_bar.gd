extends ProgressBar

func _on_stamina_component_stamina_updated(amount: int) -> void:
	self.value = amount
	pass # Replace with function body.

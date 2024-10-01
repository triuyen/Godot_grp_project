extends CanvasGroup

@export var blink_duration: float = 0.3 

func _start_blinking() -> void:
	var blink_time = 0.0
	while blink_time < blink_duration:
		$sprite.modulate = Color(10.0, 10.0, 10.0, 0.7)
		await get_tree().create_timer(0.05).timeout
		$sprite.modulate = Color(1.0, 1.0, 1.0)
		await get_tree().create_timer(0.05).timeout
		blink_time += 0.1 

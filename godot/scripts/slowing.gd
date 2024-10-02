extends Node

@export var slow_ratio: float = 0.3
@export var slow_duration: float = 1.0

func _on_player_hit(area: Node2D) -> void:
	SignalBus.slow_player.emit(slow_ratio, slow_duration)

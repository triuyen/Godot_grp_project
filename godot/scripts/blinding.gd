extends Node

@export var blinding_time: float = 1.0

func _on_player_hit(area: Node2D) -> void:
	SignalBus.blind_player.emit(blinding_time)

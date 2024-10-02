class_name HitboxComponent extends Area2D

signal _on_dies_on_hit

@export var damage = 100
@export var dies_on_hit: bool = false

func _on_body_entered(body: Node2D) -> void:
	if dies_on_hit:
		_on_dies_on_hit.emit()

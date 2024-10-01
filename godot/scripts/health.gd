class_name HealthComponent extends Node

signal on_death

@export var hp = 100

func _ready() -> void:
	pass
	
func take_damage(dmg: int):
	hp -= dmg
	if hp <= 0:
		on_death.emit()
	print(hp)

class_name HealthComponent extends Node

@onready var health_bar: ProgressBar = %health_bar

signal on_death
signal health_updated(amount: int)

@export var hp = 100
const MAX_HEALTH: int = 100

func _ready() -> void:
	health_bar.value = MAX_HEALTH
	
func take_damage(dmg: int):
	hp -= dmg
	hp = clamp(hp, 0, MAX_HEALTH)
	health_updated.emit(hp)
	if hp <= 0:
		on_death.emit()

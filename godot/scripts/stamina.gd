class_name StaminaComponent extends Node2D

@onready var stamina_bar: ProgressBar = %stamina_bar
@onready var timer: Timer = %Timer

@export var MAX_STAMINA: int = 5
var stamina: int = 5
var regen_speed: float = 1.0

signal stamina_updated(amount: int)

func _ready() -> void:
	timer.set_wait_time(regen_speed)
	stamina = MAX_STAMINA
	stamina_bar.value = stamina
	stamina_bar.max_value = stamina

func _consume_stamina() -> void:
	stamina -= 1
	stamina = clamp(stamina, 0, MAX_STAMINA)

func _regenerate_stamina() -> void:
	stamina += 1
	stamina = clamp(stamina, 0, MAX_STAMINA)
	stamina_updated.emit(stamina)

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	_regenerate_stamina()
	stamina = clamp(stamina, 0, MAX_STAMINA)

func _on_player_has_dashed() -> void:
	print("dashed")
	_consume_stamina()
	stamina_updated.emit(stamina)

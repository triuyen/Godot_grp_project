extends Node2D

@onready var current_level = $level_1
# stats 
var damage_amount: int = 20

func _ready() -> void:
	var levelManager = current_level.getmode("levelManager")
	levelManager.connect()
	pass

func _process(_delta: float) -> void:
	pass

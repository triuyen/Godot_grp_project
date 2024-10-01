extends Node2D

@onready var current_level = $level_1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	var levelManager = current_level.getmode("levelManager")
	levelManager.connect("level_changed", self, )

#func _change_to_lvl2(mapToLoad : String):
#	next_level = load("res://game_design/level_2.tscn")
#	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter_signal():
	pass

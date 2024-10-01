extends Area2D

#export(PackedScene) var target_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if get_overlapping_areas().size() > 0:
			next_level()

func next_level():
	var ERR = get_tree().change_scene_to_file("res://game_design/level_2.tscn")
	

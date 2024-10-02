extends Control

# Function to start the game
func _on_StartButton_pressed():
	# Replace 'res://GameScene.tscn' with the path to your main game scene
	get_tree().change_scene_to_file("res://game_design/game_desgin.tscn")

# Function to quit the game
func _on_QuitButton_pressed():
	get_tree().quit()

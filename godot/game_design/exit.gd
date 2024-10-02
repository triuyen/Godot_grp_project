extends Area2D
# Preload the UI scene
@onready var popup_scene = preload("res://game_design/exit_UI.tscn")
var ui_instance

func _on_Area2D_body_entered(body):
	if body.name == "player":  # Check for a specific object by name
		print("Player is overlapping with", body.name)
		_on_show_popup_button_pressed()
		
# Function to trigger the popup
func _on_show_popup_button_pressed():
	if not ui_instance:
		# Create an instance of the UI.tscn
		ui_instance = popup_scene.instantiate()
		add_child(ui_instance)
		ui_instance.popup_centered()


	
	

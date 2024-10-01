extends Area2D
# Preload the UI scene
var ui_scene = preload("res://game_design/exit_UI.tscn")
var ui_instance
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if get_overlapping_areas().size() > 0:
			print("going to next level")
			_on_show_popup_button_pressed()

# Function to trigger the popup
func _on_show_popup_button_pressed():
	if not ui_instance:
		# Create an instance of the UI.tscn
		ui_instance = ui_scene.instance()
		print(ui_instance)
		add_child(ui_instance)

	# Ensure it's a PopupPanel and then show it
		ui_instance.popup_centered()
		print("POP RAISED ")

	
	

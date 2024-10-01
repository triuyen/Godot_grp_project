extends Button

func _input(event):
	if event.is_action_pressed():
			get_tree().quit()
			
	

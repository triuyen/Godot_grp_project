extends Panel
# Declare references to the buttons and label
@onready var confirm_button = $ConfirmButton
@onready var cancel_button = $CancelButton

func _ready():
	# Connect the button signals to their respective functions
	confirm_button.connect("pressed",Callable(self, "_on_confirm_button_pressed"))
	cancel_button.connect("pressed", Callable(self, "_on_cancel_button_pressed"))

# Function for when the confirm button is pressed
func _on_confirm_button_pressed():
	get_tree().quit()
	print(" EXIT CONFIRMED")

# Function for when the cancel button is pressed
func _on_cancel_button_pressed():
	print(" CANCEL EXIT, BACK TO GAME ")
	get_tree().change_scene_to_file("res://game_design/game_desgin.tscn")

	

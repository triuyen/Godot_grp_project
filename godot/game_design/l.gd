extends Area2D

# Reference to the AnimatedSprite2D node
@onready var animated_sprite = $chest_underground
var animation_playing = false  # Track if the animation is playing

func _ready():
	# Connect the signal for when another body enters the Area2D
	connect("body_entered", Callable(self, "_on_body_entered"))
	# Connect the signal for when the animation finishes
	animated_sprite.connect("animation_finished",Callable( self, "_on_animation_finished"))


# Detect left mouse click
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not animation_playing and get_overlapping_bodies().size() > 0:  # Ensure overlap and animation is not playing
			animated_sprite.play("open_chest")  # Play your animation
			animation_playing = true  # Set flag to indicate animation is playing
			print("Left mouse button clicked, animation triggered")
# Function triggered when an object enters the collision area
func _on_body_entered(body):
	print("Body entered: ", body.name)

# Function triggered when the animation finishes
func _on_animation_finished():
	animation_playing = false  # Reset the flag when the animation is done
	print("Animation finished playing")

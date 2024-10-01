#extends Node2D
## Called when the node enters the scene tree for the first time.
#@onready var animated_sprite = $chest_underground
#
#var animation_playing = false  # A flag to track if the animation is playing
#
#func _ready():
	## Ensure the animation doesn't loop
	#animated_sprite.stop() # Stop any initial playing
	#animated_sprite.connect("animation_finished",Callable( self, "_on_animation_finished"))
#
#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#if get_overlapping_areas().size() > 0:
			#if animated_sprite != null:
				#animated_sprite.play("open_chest",3,false)
			#else:
				#print(animated_sprite, "Is null")
#
#func _on_animation_finished():
	#animation_playing = false
	#print("Animation finished playing")

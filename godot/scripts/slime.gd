extends  CharacterBody2D

@export var has_infinite_vision = false
@export var speed: float = 100

var knockback_force = 300
var is_knocked = false
var target: CharacterBody2D

func _ready() -> void:
	if has_infinite_vision:
		target = %player

func _process(delta: float) -> void:
	if is_knocked:
		return
	# move direction
	if is_instance_valid(target):
		var direction_vector = (target.global_position - self.global_position).normalized()
		self.velocity = direction_vector * speed
	
func _physics_process(delta: float) -> void:
	self.move_and_slide()
	

func _on_hit_taken(hit_position: Vector2) -> void:
	var hit_direction = (self.global_position - hit_position).normalized()
	self.velocity = hit_direction * knockback_force
	is_knocked = true
	
	await get_tree().create_timer(0.2).timeout
	
	self.velocity = Vector2.ZERO
	is_knocked = false
	

func _on_death() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(%sprite, "scale", Vector2(), 0.3)
	tween.tween_callback(queue_free)
	
#func _on_player_detected(area: Area2D) -> void:
	#target = area.global_position

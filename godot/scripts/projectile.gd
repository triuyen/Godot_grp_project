extends Area2D

var direction: Vector2 = Vector2.RIGHT
const SPEED : float = 300

func _ready():
	pass

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta


func _on_life_timeout() -> void:
	queue_free() 

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	queue_free()

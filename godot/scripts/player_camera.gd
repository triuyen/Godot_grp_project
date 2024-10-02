extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.blind_player.connect(func (time): _on_blind(time))


func _on_blind(time: float):
	$blind_texture.visible = true
	await get_tree().create_timer(time).timeout
	$blind_texture.visible = false

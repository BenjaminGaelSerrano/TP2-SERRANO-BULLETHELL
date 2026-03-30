extends TextureRect
var VelocidadMovimiento = -90
func _ready() -> void:
	flip_v = true
	position.y = 1536
func _process(delta: float) -> void:
	position.y += VelocidadMovimiento * delta
	if position.y <= -1536:
		position.y += 1536 * 2

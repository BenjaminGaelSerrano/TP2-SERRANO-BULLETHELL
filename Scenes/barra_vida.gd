extends HBoxContainer
func _ready():
	get_node("../Jugador").vidaPerdida.connect(_on_jugador_vida_perdida)
func _on_jugador_vida_perdida() -> void:
	var corazones = $".".get_children()
	for corazon in corazones :
		if corazon.visible:
			corazon.hide()
			break

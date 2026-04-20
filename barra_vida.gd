extends HBoxContainer
func _ready():
	get_node("../Jugador").vida_perdida.connect(sacarCorazon())
func sacarCorazon():
	var corazones = $".".get_children()
	for corazon in corazones :
		if corazon.visible:
			queue_free()

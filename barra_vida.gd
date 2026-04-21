extends HBoxContainer
func _ready():
	get_node("../Jugador").vidaPerdida.connect(sacarCorazon)
func sacarCorazon():
	var corazones = $".".get_children()
	for corazon in corazones :
		if corazon.visible:
			corazon.hide
			break

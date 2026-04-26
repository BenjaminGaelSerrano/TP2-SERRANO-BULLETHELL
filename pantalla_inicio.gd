extends CanvasLayer
@onready var inicio=$Control
@onready var mensaje =$Control/Mensaje
@onready var boton = $Control/Boton

func _ready() -> void:
	get_tree().paused = true
	mensaje.text = "¡Bienvenido!"
	boton.text = "Iniciar Partida"
	inicio.visible = true
	get_node("../Jugador").jugadorMuerto.connect(perdiste)
	get_node("../Cometa").cometaMuerto.connect(ganaste)
func perdiste():
	get_tree().paused = true
	mensaje.text ="¡Perdiste!"
	boton.text = "Reintentar"
	inicio.visible = true
func ganaste():
	get_tree().paused = true
	mensaje.text ="¡Ganaste!"
	boton.text = "Nueva partida"
	inicio.visible = true		
func botonApretado():
	if boton.text=="Iniciar Partida" or boton.text=="Reanudar":
		get_tree().paused = false
		inicio.visible=false
	else :
		get_tree().reload_current_scene()	 	
func _input(event):
	if event.is_action_pressed("Pausa"):
		get_tree().paused = true
		mensaje.text = "Partida Pausada"
		boton.text = "Reanudar"
		inicio.visible = true

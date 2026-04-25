extends Area2D
var direccion= Vector2(0.3,1.0)
var anchoPantalla
var duracion=20
const velocidad= 300
@onready var animacion= $AnimacionMeteorito
@onready var jugador =$Jugador
@onready var cometa= $Cometa
func _ready() -> void:
	anchoPantalla=get_viewport_rect().size.x
	animacion.play("Normal")
	jugador = get_tree().get_root().find_child("Jugador", true, false)
	cometa = get_tree().get_root().find_child("Cometa", true, false)
func _physics_process(delta: float) -> void:
	position+=direccion*velocidad*delta
	position.x =clamp(position.x,100,anchoPantalla-100)
	if position.x <= 100 or position.x >= anchoPantalla - 100:
		direccion.x = -direccion.x
	duracion-=delta
	if duracion	<= 0 :
		queue_free()
func destruir():
	animacion.play("Roto")
	jugador.meteoritos_destruidos+=1
	if jugador.meteoritos_destruidos>= 100:
		cometa.aparecer() 
	set_physics_process(false)
	await animacion.animation_finished
	queue_free()
func _on_area_entered(area):
	if area.get_parent().name == "Jugador":
		area.get_parent().recibir_danio()
	destruir()

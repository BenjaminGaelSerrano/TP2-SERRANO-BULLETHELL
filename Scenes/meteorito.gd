extends Area2D
var direccion= Vector2(0.3,1.0)
var anchoPantalla
@onready var animacion= $AnimacionCometa
func _ready() -> void:
	anchoPantalla=get_viewport_rect().size.x
func _physics_process(delta: float) -> void:
	position+=direccion*delta
	position.x =clamp(position.x,100,anchoPantalla-100)
	if position.x <= 100 or position.x >= anchoPantalla - 100:
		direccion.x = -direccion.x
func destruir():
	set_physics_process(false)
	animacion.play("Destruccion")
	await animacion.animation_finished
	queue_free()		
func _on_body_entered(body):
	if body.name== "jugador" :
		body.recibir_danio()
	destruir()
func _on_area_entered(area):
	destruir()

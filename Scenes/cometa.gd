extends CharacterBody2D
const velocidad = 150
const meteoritoo = preload("res://Scenes/meteorito.tscn")
var vidas=90
var aparecido=false
@onready var animacion = $AnimacionCometa
var anchoPantalla
var alturaPantalla
var direccion= 0
const tiempoVisible= 10.0
var tiempo=0;
func _ready() -> void:
	anchoPantalla=get_viewport_rect().size.x
	alturaPantalla= get_viewport_rect().size.y
	position= Vector2(anchoPantalla / 2, -200)
func _physics_process(delta):
	if not aparecido:
		return
	tiempo+=delta
	if tiempo>= tiempoVisible:
		aparecido=false
		position= Vector2(anchoPantalla / 2, -200)
		return
	velocity.x = direccion * velocidad
	velocity.y=0
	move_and_slide()
	position.x =clamp(position.x,100,anchoPantalla-100)
	if position.x <= 100 or position.x >= anchoPantalla - 100:
		direccion = -direccion
func aparecer():
	aparecido= true
	position= Vector2(anchoPantalla / 2, 100)
	direccion=1			
func recibir_danio():
	vidas-=1
	if(vidas<=0):
		animacion.play("Destruccion")
		queue_free()
#func disparar():
	

extends CharacterBody2D
const velocidad = 400
var vidas=3
var meteoritos_destruidos=0
const Bala= preload("res://Scenes/bala.tscn")
@onready var animacion = $"AnimaciónJugador"
var anchoPantalla
var direccion= 0
func _ready() -> void:
	anchoPantalla=get_viewport_rect().size.x
func _physics_process(delta):
	if Input.is_action_pressed("JugadorIzquierda"):
		direccion = -1
	elif Input.is_action_pressed("JugadorDerecha"):
		direccion = 1  
	else:
		direccion=0	  
	velocity.x = direccion * velocidad
	move_and_slide()
	position.x =clamp(position.x,100,anchoPantalla-100)
	if direccion == -1:
		animacion.play("Izquierda")
	elif direccion == 1:
		animacion.play("Derecha")
	else:
		animacion.play("Adelante")	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Disparar"):
		var bala= Bala.instantiate()
		if direccion == -1:
			bala.position= %Izquierda.global_position
		elif direccion == 1:
			bala.position= %Derecha.global_position
		else:
			bala.position= %Centro.global_position
		bala.direccionX= direccion
		get_parent().add_child(bala)		
func recibir_danio():
	vidas-=1
	if(vidas<=0):
		queue_free()
		animacion.play("Muerte")
func _on_body_entered(body):
	if body.name== "jugador" :
		body.recibir_danio()
				

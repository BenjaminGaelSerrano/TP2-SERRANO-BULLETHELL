extends CharacterBody2D
const velocidad = 400
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
		bala.position= position
		bala.direccionX= direccion
		get_parent().add_child(bala)		

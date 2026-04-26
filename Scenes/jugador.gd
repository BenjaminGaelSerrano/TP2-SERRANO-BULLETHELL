extends CharacterBody2D
const velocidad = 400
var vidas=3
signal jugadorMuerto
var invencible=false
var meteoritos_destruidos=0
signal vidaPerdida
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
	if vidas <= 0:
		return
	if invencible:
		return
	invencible= true
	vidas-=1
	vidaPerdida.emit()
	set_physics_process(false)
	animacion.play("Daño")
	await get_tree().create_timer(0.5).timeout
	set_physics_process(true)
	invencible =false
	if vidas <= 0:
		set_physics_process(false)
		animacion.play("Muerte")
		await animacion.animation_finished
		queue_free()
		jugadorMuerto.emit()

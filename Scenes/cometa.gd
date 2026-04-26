extends CharacterBody2D
const velocidad = 500
signal cometaMuerto
const meteoritoo = preload("res://Scenes/meteorito.tscn")
@onready var jugador = $"../Jugador"
var vidas=50
var invencible=false
var aparecido=false
@onready var timer= $TimerDisparo
@onready var animacion = $AnimacionCometa
var anchoPantalla
var alturaPantalla
var direccion= 0
const tiempoVisible= 10.0
var tiempo=0;
func _ready() -> void:
	animacion.play("Cometa Normal")
	anchoPantalla=get_viewport_rect().size.x
	alturaPantalla= get_viewport_rect().size.y
	position= Vector2(anchoPantalla / 2, -200)
	direccion=1
func _physics_process(delta):
	tiempo+=delta
	if tiempo>= tiempoVisible:
		aparecido=false
		position= Vector2(anchoPantalla / 2, -200)
		tiempo=0
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
	timer.start()
func recibir_danio():
	if invencible:
		return
	invencible = true
	vidas -= 1
	if vidas <= 0:
		animacion.play("Destruccion")
		await animacion.animation_finished
		queue_free()
		cometaMuerto.emit()
	await get_tree().create_timer(0.5).timeout
	invencible = false
func disparar():
	var nuevaBala= meteoritoo.instantiate()
	nuevaBala.position=position
	var xAleatoria = randf_range(-0.8, 0.8)
	nuevaBala.direccion = Vector2(xAleatoria, 1).normalized()
	get_parent().add_child(nuevaBala)	
func _on_timer_disparo_timeout() -> void:
	disparar()
func _on_hitbox_area_entered(body: Node2D) -> void:
	recibir_danio()

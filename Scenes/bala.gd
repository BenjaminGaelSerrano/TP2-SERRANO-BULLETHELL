extends Area2D
const velocidad = 1000
var direccionX=0
var inclinacionBala= 700
func _ready() -> void:
	if direccionX== -1 :
		rotation= deg_to_rad(-125)
	elif direccionX== 1:
		rotation = deg_to_rad(-40)	
func _physics_process(delta):
	position.y-= velocidad * delta
	position.x += inclinacionBala* delta * direccionX
func _on_body_entered(body):
	queue_free()

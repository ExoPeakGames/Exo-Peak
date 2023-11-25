extends Area2D

@export var damage : int = 10
var SPEED = 700
var direction : bool = true

func _physics_process(delta):
	if direction:
		position += transform.x * SPEED * delta
	else:
		position -= transform.x * SPEED * delta
	#velocity.x = SPEED * delta
	#translate(velocity)
	#$AnimatedSprite.play("shoot")

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		queue_free()
		body.hit(damage)

extends CharacterBody2D

@export var damage_dealt = 1
@export var health: float = 25
@export var SPEED : float = 125
@export var FALL_STRENGTH : float = 500
@export var GRAVITY : float = 375
@export_range(0, 1.0) var ACCELERATION : float = 0.5
@export_range(0, 1.0) var FRICTION : float = 0.5
var follow_player = false
var player = null
var player_in_range = false


func _physics_process(delta):
	if follow_player:
		position += (player.position - position)/SPEED
		$enemy.play("walk")
		if (player.position.x - position.x) < 0:
			$enemy.flip_h = false
		else:
			$enemy.flip_h = true
	else:
		$enemy.play("idle")
	
	if player_in_range:
		attack()
	
	var grav = GRAVITY
	if (velocity.y >= 0):
		grav *= FALL_STRENGTH
	
	velocity.y += grav * delta
	set_velocity(velocity)
	move_and_slide()

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		follow_player = true

func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
		follow_player = false

func hit(damage : int):
	health -= damage
	$health_bar.value = health
	if (health <=  0):
		$enemy.play("death")
		queue_free()

func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_in_range = true

func _on_hitbox_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_in_range = false

func attack():
	if $cooldown_timer.is_stopped():
		$enemy.play("bite")
		print("attack")
		player.take_damage(damage_dealt)
		$cooldown_timer.start()

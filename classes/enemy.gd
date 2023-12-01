class_name Enemy
extends CharacterBody2D

@export var damage_dealt = 1
@export var health: float = 3
@export var SPEED : float = 125
@export var FALL_STRENGTH : float = 500
@export var GRAVITY : float = 375
@export var can_bite : bool 
@export var immobile : bool
@export_range(0, 1.0) var ACCELERATION : float = 0.5
@export_range(0, 1.0) var FRICTION : float = 0.5
var alive : bool = true
var follow_player = false
var player = null
var in_range
var face_left : bool

func _init():
	scale.x = -1
	face_left = true

func _physics_process(delta):
	if follow_player and alive:
		if not immobile:
			position += (player.position - position)/SPEED
		if (player.position.x - position.x) < 0:
			if not face_left:
				$Flippable/enemy.flip_left()
		else:
			if face_left:
				$Flippable/enemy.flip_right()
	
	if in_range or (is_in_group("explosive") and not alive):
		attack()
	else:
		$Flippable/enemy.attack = false
	
	var grav = GRAVITY
	if (velocity.y >= 0):
		grav *= FALL_STRENGTH
	
	velocity.y += grav * delta
	set_velocity(velocity)
	move_and_slide()

func _on_detection_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body == null:
		return
	if body.is_in_group("player"):
		player = body
		follow_player = true

func _on_detection_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body == null:
		return
	if body.is_in_group("player"):
		follow_player = false
		player = null
		#$Flippable/enemy.flip_right()

func take_damage(amount : int):
	health -= amount
	$health_bar.value = health
	if (health <= 0):
		alive = false

func attack():
	if is_in_group("explosive"):
		alive = false
		await $Flippable/enemy.animation_finished
		$Flippable/hitbox.deal_damage()
		return
	if $Flippable/hitbox/cooldown_timer.is_stopped() and in_range:
		$Flippable/hitbox.deal_damage()
		$Flippable/enemy.attack = true
		$Flippable/hitbox/cooldown_timer.start()

extends CharacterBody2D

var health = 100
var jumping = false
var ammo = 6
var facing : bool = true

#var enemy_in_range = false

@export var SPEED : float = 50
@export var FALL_STRENGTH : float = 2
@export var GRAVITY : float = 375
@export var JUMP_SPEED : float = -175
@export var bullet : PackedScene
@export_range(0, 1.0) var ACCELERATION : float = 0.5
@export_range(0, 1.0) var FRICTION : float = 0.5

@onready var was_on_floor = is_on_floor()

func _ready():
	set_notify_transform(true)

func _notification(what):
	if what == NOTIFICATION_TRANSFORM_CHANGED and get_position_delta() != Vector2.ZERO:
		$PlayerCamera.position = Vector2(208,120)-position.posmodv(Vector2(208,120))

func _physics_process(delta):
	
	var direction : float = 0
	if Input.is_action_pressed("move_right"):
		direction += 1
		facing = true
		$player.flip_h = false
		$player/muzzle.position.x = 10
	if Input.is_action_pressed("move_left"):
		direction -= 1
		facing = false
		$player.flip_h = true
		$player/muzzle.position.x = -10
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
	
	if (Input.is_action_pressed("attack") && $cooldown_timer.is_stopped()):
		shoot()
		$cooldown_timer.start()
		# possible timing issue?
	
	var grav = GRAVITY
	if (velocity.y >= 0) or not jumping:
		grav *= FALL_STRENGTH
	
	velocity.y += grav * delta
	
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	
	if not was_on_floor and is_on_floor():
		pass  # play sound effect
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED
		jumping = true
		# play sound effect
		
	elif not Input.is_action_pressed("jump") or is_on_floor():
		jumping = false
	
	was_on_floor = is_on_floor()

func _on_reload():
	ammo = 6

func take_damage(damage : int):
	health -= damage
	$health_bar.value = health
	print(damage)
	if (health <=  0):
		# play death animation
		# game over
		print("game over")
		queue_free()
		MenuButtons._on_return_button_pressed()
	# play sound effect

func shoot():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $player/muzzle.global_transform
	b.direction = facing

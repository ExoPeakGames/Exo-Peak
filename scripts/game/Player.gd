extends CharacterBody2D

var game_over = false
var health = 8
var jumping = false
var ammo = 6
var spawner = null 
var playerSave: PlayerSave
var newGame: NewGame

@export var SPEED : float = 80
@export var FALL_STRENGTH : float = 2
@export var GRAVITY : float = 375
@export var JUMP_SPEED : float = -150
@export_range(0, 1.0) var ACCELERATION : float = 0.5
@export_range(0, 1.0) var FRICTION : float = 0.5

@onready var was_on_floor = is_on_floor()
@onready var Bullet = preload("res://scenes/projectiles/bullet.tscn")
var paused = false

func _ready():
	set_notify_transform(true)

func _init():
	var gameMode
	if PlayerData.new_game:
		newGame = NewGame.load_or_create()
		gameMode = newGame
	else:
		playerSave = PlayerSave.load_or_create()
		gameMode = playerSave
	if gameMode:
		position = gameMode.position

func _notification(what):
	if what == NOTIFICATION_TRANSFORM_CHANGED and get_position_delta() != Vector2.ZERO:
		#warning-ignore:integer_division
		$PlayerCamera.position = Vector2(104,60)-position.posmodv(Vector2(208,120))
	

func _physics_process(delta):
	var direction : float = 0
	if not game_over:
		if Input.is_action_pressed("move_right"):
			direction += 1
		if Input.is_action_pressed("move_left"):
			direction -= 1
		if direction != 0:
			velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION)
		else:
			velocity.x = lerp(velocity.x, 0.0, FRICTION)
		
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
			AchievementManager.increase_achievement_progress("jumping", 1)
			# play sound effect
			
		elif not Input.is_action_pressed("jump") or is_on_floor():
			jumping = false
		
		if Input.is_action_pressed("attack") and $cooldown_timer.is_stopped(): # and PlayerData.has_gun:
			shoot()
			$cooldown_timer.start()
		
		was_on_floor = is_on_floor()


func _on_reload():
	ammo = 6

func take_damage(amount):
	health -= amount
	$UI/HealthBar.frame = health
	if (health <= 0 and not game_over):
		# play death animation
		# game over
		game_over = true
		print("game over")
		MenuButtons._on_play_button_pressed()
		await $"../../../AnimationPlayer".animation_finished
	# play sound effect

func shoot():
	var b = Bullet.instantiate()
	b.init(Vector2($Flippable.scale.x, 0))
	add_sibling(b)
	#b.direction = Vector2($Flippable.scale.x, 0)
	b.global_position = $Flippable/Muzzle.global_position

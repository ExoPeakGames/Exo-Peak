extends CharacterBody2D

@export var damage : int = 10
var SPEED = 700
var direction : Vector2 = Vector2(1,0)

func init(dir: Vector2):
	direction = dir

func _ready():
	velocity = SPEED * direction

func _physics_process(_delta):
	move_and_slide()


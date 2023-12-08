extends Area2D

var playerSave: PlayerSave
var newGame: NewGame
var gameMode

func _ready():
	if PlayerData:
		newGame = NewGame.load_or_create()
		playerSave = PlayerSave.load_or_create()
		gameMode = newGame
	else:
		gameMode = playerSave
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.spawnerLocation = position
		gameMode.position = position
		playerSave.position = position
		playerSave.save()
		print("chek")

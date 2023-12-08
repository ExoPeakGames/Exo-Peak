class_name NewGame extends Resource

@export var health: int = 8
@export var position = Vector2(104, 100)

static func load_or_create() -> NewGame:
	var res: NewGame = load("res://resources/keepTres/new_game.tres") as NewGame
	if !res:
		res = NewGame.new()
	return res

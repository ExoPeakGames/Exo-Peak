extends Node

var pSave: PlayerSave

var spawnerLocation = Vector2(104, 100):
	set(value):
		pSave.position = value
	get:
		return pSave.position

var health = 8:
	set(value):
		pSave.health = value
	get:
		return pSave.health

var lastCheckpoint = Vector2(104, 100):
	set(value):
		pSave.lastCheckpoint = value
		pSave.position = value
	get:
		return pSave.lastCheckpoint

func new_game():
	pSave = PlayerSave.new()
	
func load_game():
	pSave = PlayerSave.load_or_create()
	save()
	
func save():
	pSave.save()

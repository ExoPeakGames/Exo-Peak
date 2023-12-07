extends Node

@onready var preferences := UserPreferences.load_or_create()

@export_range(0, 1, 0.001) var master: float = 1.0 :
	set(value):
		preferences.master = value
		AudioServer.set_bus_volume_db(0, linear_to_db(value))
	get:
		return preferences.master

@export_range(0, 1, 0.001) var music: float = 1.0 :
	set(value):
		preferences.music = value
		AudioServer.set_bus_volume_db(1, linear_to_db(value))
	get:
		return preferences.music

@export_range(0, 1, 0.001) var sfx: float = 1.0 :
	set(value):
		preferences.sfx = value
		AudioServer.set_bus_volume_db(2, linear_to_db(value))
	get:
		return preferences.sfx

@export var fullscreen: bool = false :
	set(value):
		preferences.fullscreen = value
		if value:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get:
		return preferences.fullscreen

@export var vsync: bool = false :
	set(value):
		preferences.vsync = value
		if value:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		else:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	get:
		return preferences.vsync

func save():
	preferences.save()

func _ready():
	master = preferences.master
	music = preferences.music
	sfx = preferences.sfx
	fullscreen = preferences.fullscreen
	vsync = preferences.vsync

func toggle_fullscreen():
	fullscreen = not preferences.fullscreen

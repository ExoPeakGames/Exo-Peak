extends Control

var user_pref: UserPreferences

func _ready():
	user_pref = UserPreferences.load_or_create()
	AudioServer.set_bus_volume_db(0, linear_to_db(user_pref.master))
	AudioServer.set_bus_volume_db(1, linear_to_db(user_pref.music))
	AudioServer.set_bus_volume_db(2, linear_to_db(user_pref.sfx))

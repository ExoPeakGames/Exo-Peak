extends Control

var userPref: UserPreferences
func _ready():
	userPref = UserPreferences.load_or_create()
	AudioServer.set_bus_volume_db(0, linear_to_db(userPref.master))
	AudioServer.set_bus_volume_db(1, linear_to_db(userPref.music))
	AudioServer.set_bus_volume_db(2, linear_to_db(userPref.sfx))
	if userPref.fullScreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if userPref.vsync == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func _on_play_button_pressed():
	MenuButtons._on_play_button_pressed()

func _on_settings_button_pressed():
	MenuButtons._on_settings_button_pressed()

func _on_achievements_button_pressed():
	MenuButtons._on_achievements_button_pressed()

func _on_quit_button_pressed():
	get_tree().quit()

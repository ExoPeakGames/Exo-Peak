extends CanvasLayer

var userPref: UserPreferences
func _ready():
	userPref = UserPreferences.load_or_create()
	$"Settings_Background/Fullscreen/fullscreen".button_pressed = userPref.fullScreen
	$"Settings_Background/V-sync/vsync".button_pressed = userPref.vsync

func _on_return_button_pressed():
	if MenuButtons.pmenuButton:
		hide()
	else:
		MenuButtons._on_return_button_pressed()


func _on_fullscreen_toggled(button_pressed):
	userPref.fullScreen = button_pressed
	userPref.save()
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_vsync_toggled(button_pressed):
	userPref.vsync = button_pressed
	userPref.save()
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

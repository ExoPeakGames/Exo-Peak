extends Control

func _on_play_button_pressed():
	$"LeftPanel/VBoxContainer/PlayButton/playModes".show()

func _on_settings_button_pressed():
	MenuButtons._on_settings_button_pressed()

func _on_achievements_button_pressed():
	MenuButtons._on_achievements_button_pressed()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_new_game_pressed():
	PlayerData.new_game = true
	MenuButtons._on_play_button_pressed()

func _on_load_game_pressed():
	PlayerData.new_game = false
	MenuButtons._on_play_button_pressed()

func _on_back_button_pressed():
	$"LeftPanel/VBoxContainer/PlayButton/playModes".hide()



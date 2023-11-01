extends Control

func _ready():
	MenuButtons.handleSounds(self)
	
func _on_play_button_pressed():
	MenuButtons._on_play_button_pressed()

func _on_settings_button_pressed():
	MenuButtons._on_settings_button_pressed()

func _on_achievements_button_pressed():
	MenuButtons._on_achievements_button_pressed()

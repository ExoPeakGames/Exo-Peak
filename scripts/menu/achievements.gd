extends Control

func _ready():
	MenuButtons.handleSounds(self)

func _on_return_button_pressed():
	MenuButtons._on_return_button_pressed()

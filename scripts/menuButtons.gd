extends Control

signal scene_change(scene_name: String)

func _on_return_button_pressed():
	emit_signal("scene_change", "title")

func _on_play_button_pressed():
	emit_signal("scene_change", "game")

func _on_settings_button_pressed():
	emit_signal("scene_change", "settings")

func _on_achievements_button_pressed():
	emit_signal("scene_change", "achievements")

# to disable ANY input (mouse, keyboard, mic) during scene transitions

# add any cleanup logic here. this will run while deleting an instance of a scene.
func cleanup():
	queue_free()

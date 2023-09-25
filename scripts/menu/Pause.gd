extends Control

func _input(event):
	if Input.is_key_pressed(KEY_P):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

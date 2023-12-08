extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("wowowwowowowowowow")
		MenuButtons._on_scene_2()
	pass 

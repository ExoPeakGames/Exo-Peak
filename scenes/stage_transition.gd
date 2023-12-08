extends Area2D
var next_scene = null

func _on_body_entered(body):
	print("you made it!")
	if body.is_in_group("player"):
		# we need to do something! Do we emit a signal?

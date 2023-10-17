extends Node2D

@onready var current_scene = $Title_Screen
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_scene.connect("scene_change", _handle_scene_change);

func _handle_scene_change(go_to_scene: String):
	var next_scene
	var next_scene_name: String
	
	match go_to_scene:
		"settings":
			next_scene_name = "Settings"
		"game":
			next_scene_name = "scene_1"
		"title":
			next_scene_name = "title_screen"
		"acheivements":
			next_scene_name = "Achievements"
		_:
			return
		
	var temp = load("res://scenes/" + next_scene_name + ".tscn")
	next_scene = temp.instantiate()
	call_deferred("add_child", next_scene)
	next_scene.connect("scene_change", _handle_scene_change)
	current_scene.queue_free()
	current_scene = next_scene

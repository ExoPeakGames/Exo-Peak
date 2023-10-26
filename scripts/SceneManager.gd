extends Node2D

# Game will always load with Title_Screen and an animation player
# Global variables
@onready var current_scene = $Title_Screen
@onready var animate  = $AnimationPlayer
var next_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_scene.connect("scene_change", _handle_scene_change);

func _handle_scene_change(go_to_scene: String):
	var next_scene_name: String
	# Thinking of adding a animation name variable to later choose what animations to play
	# For now, I added simple fade in/out animations.
	# var animation_name: String
	match go_to_scene:
		"settings":
			next_scene_name = "Settings"
			#animation_name =
		"game":
			next_scene_name = "scene_1"
			#animation_name =
		"title":
			next_scene_name = "title_screen"
			#animation_name =
		"achievements":
			next_scene_name = "Achievements"
			#animation_name =
		_:
			return
		
	var temp = load("res://scenes/" + next_scene_name + ".tscn")
	#animate.play(animation_name)
	animate.play("fade_in")
	current_scene.inputHandle("disable")
	next_scene = temp.instantiate()
	await animate.animation_finished
	call_deferred("add_child", next_scene)
	next_scene.connect("scene_change", _handle_scene_change)

func _on_animation_player_animation_finished(anim_name):
	# added a match here just in case we would like to do something different for each animation
	match anim_name:
		"fade_in":
			#animate.play(animation_name)
			current_scene.cleanup()
			current_scene = next_scene
			animate.play("fade_out")
			await animate.animation_finished
			current_scene.inputHandle("enable")
		#"fade_out":
			# some customization??

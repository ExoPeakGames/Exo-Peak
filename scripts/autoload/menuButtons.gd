extends Node

signal scene_change(scene_name: String)

var sounds = {
	&"UI_Hover" : AudioStreamPlayer.new(),
	&"UI_Click" : AudioStreamPlayer.new(),
}

func _ready():
	# set up audio stream players and load sound files
	for k in sounds.keys():
		sounds[k].stream = load("res://assets/audio/sfx/" + str(k) + ".mp3")
		# assign output mixer bus
		sounds[k].bus = &"UI"
		# add them to the scene tree
		add_child(sounds[k])

func _on_return_button_pressed():
	emit_signal("scene_change", "title")

func _on_play_button_pressed():
	emit_signal("scene_change", "game")

func _on_settings_button_pressed():
	emit_signal("scene_change", "settings")

func _on_achievements_button_pressed():
	emit_signal("scene_change", "achievements")

# to disable ANY input (mouse) during scene transitions
func inputHandle(handle: String):
	match handle:
		"disable":
			get_tree().get_root().set_disable_input(true)
			# disable keyboard
		"enable":
			get_tree().get_root().set_disable_input(false)
			# enable keyboard
# add any cleanup logic here. this will run while deleting an instance of a scene.
func cleanup():
	queue_free()

func handleSounds(submenu: Node):

	# connect signals to the method that plays the sounds
	install_sounds(submenu)

func install_sounds(node: Node) -> void:
	for child in node.get_children():
		if child is Button:
			child.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover") )
			child.pressed.connect( ui_sfx_play.bind(&"UI_Click") )
		
		# recursion
		install_sounds(child)

func ui_sfx_play(sound : String) -> void:
#	printt("Playing sound:", sound)
	sounds[sound].play()

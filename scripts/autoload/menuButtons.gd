extends Node

signal scene_change(scene_name: String)

var sounds = {
	&"UI_Hover" : AudioStreamPlayer.new(),
	&"UI_Click" : AudioStreamPlayer.new(),
}

func _ready():
	handleSounds()

func _on_return_button_pressed():
	print("pressing button")
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

func handleSounds():
	# set up audio stream players and load sound files
	for i in sounds.keys():
		sounds[i].stream = load("res://assets/audio/sfx/" + str(i) + ".mp3")
		# assign output mixer bus
		sounds[i].bus = &"UI"
		# add them to the scene tree
		add_child(sounds[i])

	# connect signals to the method that plays the sounds
	install_sounds(self)

func install_sounds(node: Node) -> void:
	for i in node.get_children():
		if i is Button:
			i.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover") )
			i.pressed.connect( ui_sfx_play.bind(&"UI_Click") )
		
		# recursion
		install_sounds(i)

func ui_sfx_play(sound : String) -> void:
#	printt("Playing sound:", sound)
	sounds[sound].play()

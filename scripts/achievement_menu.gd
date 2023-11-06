extends Control

signal scene_change(scene_name: String)

var sounds = {
	&"UI_Hover" : AudioStreamPlayer.new(),
	&"UI_Click" : AudioStreamPlayer.new(),
}

func _ready():
	handleSounds()
	#loadAchievementProgress()

func _on_return_button_pressed():
	emit_signal("scene_change", "title")

# to disable ANY input (mouse, keyboard, mic) during scene transitions
func inputHandle(handle: String):
	match handle:
		"disable":
			get_tree().get_root().set_disable_input(true)
		"enable":
			get_tree().get_root().set_disable_input(false)
# add any cleanup logic here. this will run while deleting an instance of a scene.
func cleanup():
	queue_free()

func handleSounds():
	# set up audio stream players and load sound files
	for i in sounds.keys():
		sounds[i].stream = load("res://Assets/Music-sfx/" + str(i) + ".mp3")
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

func loadAchievementProgress():
	$ScrollContainer/AchievementList/Achievement1/achievement1Info/achievement1Prog.value =  100 # to be updated dynamically from a player data file
	if $ScrollContainer/AchievementList/Achievement1/achievement1Info/achievement1Prog.value == 100:
		$ScrollContainer/AchievementList/Achievement1/achievement1State.texture = load("res://assets/ui/checkmark.png")
	else:
		$ScrollContainer/AchievementList/Achievement1/achievement1State.texture = load("res://assets/ui/xmark.png")
	
	$ScrollContainer/AchievementList/Achievement2/achievement2Info/achievement2Prog.value =  0
	if $ScrollContainer/AchievementList/Achievement2/achievement2Info/achievement2Prog.value == 100:
		$ScrollContainer/AchievementList/Achievement2/achievement2State.texture = load("res://assets/ui/checkmark.png")
	else:
		$ScrollContainer/AchievementList/Achievement2/achievement2State.texture = load("res://assets/ui/xmark.png")
		
	$ScrollContainer/AchievementList/Achievement3/achievement3Info/achievement3Prog.value =  0
	if $ScrollContainer/AchievementList/Achievement3/achievement3Info/achievement3Prog.value == 100:
		$ScrollContainer/AchievementList/Achievement3/achievement3State.texture = load("res://assets/ui/checkmark.png")
	else:
		$ScrollContainer/AchievementList/Achievement3/achievement3State.texture = load("res://assets/ui/xmark.png")
	

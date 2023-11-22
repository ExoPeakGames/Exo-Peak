extends CanvasLayer

func _ready():
	loadAchievementProgress()
	pass

func _on_return_button_pressed():
	if MenuButtons.pmenuButton:
		hide()
	else:
		MenuButtons._on_return_button_pressed()

func loadAchievementProgress():
	# instantiate paths and control variables
	var i = 1
	var scroll_container = $ScrollContainer
	var margin_container = scroll_container.get_node("MarginContainer")
	var achievement_list = margin_container.get_node("achievementList")
	
	# Get our achievements list
	var achievement_manager = AchievementManager.instance
	var achievements = achievement_manager.achievementList
	
	#iterate and update
	for achievement in achievements:
		# get node and store in variable
		var achievement_node_path = "achievement" + str(i)
		var achievement_node = achievement_list.get_node(achievement_node_path)
		var achievement_state  = achievement_node.get_node("achievementState")
		var achievement_info = achievement_node.get_node("achievementInfo")
		
		# get the subnodes of achievementInfo to modify
		var achievement_name = achievement_info.get_node("achievementName")
		var achievement_description = achievement_info.get_node("achievementDesc")
		var achievement_prog = achievement_info.get_node("achievementProg")
		
		# get data from achievements array
		achievement_name.text = achievements[i-1].title
		achievement_description.text = achievements[i-1].description
		achievement_prog.value = achievements[i-1].progress
		
		# update completion sprites
		if achievement_prog.value == achievement_prog.max_value:
			achievement_state.texture = load("res://assets/ui/checkmark.png")
		else:
			achievement_state.texture = load("res://assets/ui/checkmark-grey.png")
		i += 1
		
		

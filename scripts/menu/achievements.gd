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
	$ScrollContainer/achievementList/achievement1/achievementInfo/achievementProg.value = 100 # remove hard coding with dynamic updates from player data
	if $ScrollContainer/achievementList/achievement1/achievementInfo/achievementProg.value == 100:
		$ScrollContainer/achievementList/achievement1/achievementState.texture = load("res://assets/ui/checkmark.png")
	else:
		$ScrollContainer/achievementList/achievement1/achievementState.texture = load("res://assets/ui/xmark.png")
		
	$ScrollContainer/achievementList/achievement2/achievementInfo/achievementProg.value = 0
	if $ScrollContainer/achievementList/achievement2/achievementInfo/achievementProg.value == 100:
		$ScrollContainer/achievementList/achievement2/achievementState.texture = load("res://assets/ui/checkmark.png")
	else:
		$ScrollContainer/achievementList/achievement2/achievementState.texture = load("res://assets/ui/xmark.png")
		
	$ScrollContainer/achievementList/achievement3/achievementInfo/achievementProg.value = 0
	if $ScrollContainer/achievementList/achievement3/achievementInfo/achievementProg.value == 100:
		$ScrollContainer/achievementList/achievement3/achievementState.texture = load("res://assets/ui/checkmark.png")
	else:
		$ScrollContainer/achievementList/achievement3/achievementState.texture = load("res://assets/ui/xmark.png")
		
	$ScrollContainer/achievementList/achievement4/achievementInfo/achievementProg.value = 0
	if $ScrollContainer/achievementList/achievement4/achievementInfo/achievementProg.value == 100:
		$ScrollContainer/achievementList/achievement4/achievementState.texture = load("res://assets/ui/checkmark.png")
	else:
		$ScrollContainer/achievementList/achievement4/achievementState.texture = load("res://assets/ui/xmark.png")

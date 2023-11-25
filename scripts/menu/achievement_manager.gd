# AchievementManager.gd
extends Node

class_name AchievementManager

var achievementList : Array = []

# Singleton instance
static var instance = null

func _ready():
	if instance == null:
		instance = self
	else:
		queue_free()  # Ensure there is only one instance of the singleton

	# Initialize achievements (replace this with your actual achievement setup logic)
	init_achievements()

func init_achievements():
	# Create and add achievements to the list
	var achievement1 = achievement.new("Crash Landing on Who?", "Beat Stage 1", 0)
	var achievement2 = achievement.new("Trees!", "Beat Stage 2", 0)
	var achievement3 = achievement.new("So This is the Peak.", "Beat Stage 3", 0)
	var achievement4 = achievement.new("Who Knew You Could Jump?", "Jump Ten Times!", 0)
	
	#store them in list
	achievementList.append(achievement1)
	achievementList.append(achievement2)
	achievementList.append(achievement3)
	achievementList.append(achievement4)

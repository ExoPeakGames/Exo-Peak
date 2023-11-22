extends Node

class_name achievement
var title : String
var description : String
var progress : int

func _init(title: String, description: String, progress: int):
	self.title = title
	self.description = description
	self.progress = progress

func updateAchievement(value: int):
	self.progress = self.progress + value

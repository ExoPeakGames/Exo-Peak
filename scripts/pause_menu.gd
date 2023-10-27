extends CanvasLayer

var paused := false

# Called when the node enters the scene tree for the first time.
func _ready():
	if visible:
		hide()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if paused:
			unpause()
		else:
			pause()

func pause():
	get_tree().paused = true
	show()
	paused = true

func unpause():
	get_tree().paused = false
	hide()
	paused = false


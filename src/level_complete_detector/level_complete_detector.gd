class_name LevelCompleteDetector
extends Node

signal level_completed()

var completed: bool = false

func _process(_delta):
	if completed:
		return
		
	# This node will only have enemies as children
	# so when there are no enemies the level is completed
	completed = get_children().size() == 0
	
	if completed:
		print("level completed")
		level_completed.emit()


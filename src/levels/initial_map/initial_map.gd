class_name InitialMap
extends BaseLevel

func _ready():
	super()

func _on_fall_area_body_entered(_body: Player):
	assert(not next_scene_path.is_empty())
	change_level.emit(next_scene_path)
	#get_tree().change_scene_to_file(next_scene_path)


func _on_tutorial_area_body_entered(_body: Player):
	$TutorialPanel.visible = true


func _on_tutorial_area_body_exited(_body: Player):
	$TutorialPanel.visible = false

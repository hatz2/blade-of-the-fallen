class_name InitialMap
extends BaseLevel

func _ready():
	super()
	#$Player.global_position = $PlayerPos.global_position
	$TutorialPanel.visible = false

func _on_fall_area_body_entered(_body: Player):
	# TODO: Change to first level scene
	print("Player felt")


func _on_tutorial_area_body_entered(_body: Player):
	$TutorialPanel.visible = true


func _on_tutorial_area_body_exited(_body: Player):
	$TutorialPanel.visible = false

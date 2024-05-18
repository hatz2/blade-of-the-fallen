class_name MonsterStateMachine
extends StateMachine

@onready var _follow_state := $Following

func _on_detection_area_body_entered(body):
	if body is Player:
		# Change to follow state
		on_transition(_follow_state)

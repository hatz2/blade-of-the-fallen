extends StateMachine


func _on_player_detector_body_entered(body: Player):
	if current_state != $Hide:
		on_transition($Hide)


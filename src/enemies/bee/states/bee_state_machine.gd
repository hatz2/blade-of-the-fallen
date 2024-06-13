extends StateMachine

@onready var attack_state := $AttackState
@onready var hit_state := $Hit

func _on_player_detector_body_entered(player: Player):
	if current_state != attack_state:
		on_transition(attack_state)


func _on_hurtbox_hit():
	if current_state != hit_state:
		on_transition(hit_state)

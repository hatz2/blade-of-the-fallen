class_name Attacking
extends PlayerState

@export var attack_animation = "attack"
@export var ground_state: Ground

func enter():
	playback.travel(attack_animation)
	
	
func exit():
	pass


func update(_delta) -> PlayerState:
	return null
	
	
func physics_update(_delta):
	pass
	
	
func handle_input(event : InputEvent):
	pass


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == attack_animation:
		transition.emit(ground_state)

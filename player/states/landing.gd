class_name Landing
extends PlayerState

@export var landing_animation := "landing"
@export var ground_state: Ground

func enter():
	playback.travel(landing_animation)
	pass
	
func exit():
	pass

func update(_delta) -> PlayerState:
	return null
	
func physics_update(_delta):
	pass
	
func handle_input(event : InputEvent):
	pass



func _on_animation_tree_animation_finished(anim_name):
	if anim_name == landing_animation:
		transition.emit(ground_state)

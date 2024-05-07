class_name Landing
extends PlayerState

@export var landing_animation := "landing"
@export var ground_state: Ground
@export var air_state: Air
@export var attack_state: Attacking

func enter():
	playback.travel(landing_animation)
	pass
	
func exit():
	pass

func update(_delta):
	pass
	
func physics_update(_delta):
	pass
	
func handle_input(event : InputEvent):
	if event.is_action_pressed("attack"):
		transition.emit(attack_state)
	elif event.is_action_pressed("jump"):
		air_state.jumped = true
		transition.emit(air_state)



func _on_animation_tree_animation_finished(anim_name):
	if anim_name == landing_animation:
		transition.emit(ground_state)

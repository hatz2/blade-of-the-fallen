class_name Air
extends PlayerState

@export var jump_animation := "jump"
@export var falling_animation := "falling"
@export var player: CharacterBody2D
@export var landing_state: Landing

var jumped := false

func enter():
	if jumped:
		playback.travel(jump_animation)
	else:
		playback.travel(falling_animation)
	
func exit():
	jumped = false

func update(_delta):
	pass
	
func physics_update(_delta):
	if player.is_on_floor():
		transition.emit(landing_state)
	
func handle_input(_event : InputEvent):
	pass

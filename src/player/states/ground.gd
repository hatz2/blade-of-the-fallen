class_name Ground
extends PlayerState

@export var player : CharacterBody2D
@export var running_animation := "run"
@export var idle_animation := "idle"
@export var attack_state: Attacking
@export var air_state: Air

func enter():
	pass
	
func exit():
	pass

func update(_delta):
	pass
	
func physics_update(_delta):
	var direction = Input.get_axis("run_left", "run_right")
	
	# If character is moving play the run animation otherwise play idle
	if direction:
		playback.travel(running_animation)
	else:
		playback.travel(idle_animation)
		
	if not player.is_on_floor():
		transition.emit(air_state)
	
	
func handle_input(event : InputEvent):
	if event.is_action_pressed("attack"):
		transition.emit(attack_state)
	elif event.is_action_pressed("jump"):
		air_state.jumped = true
		transition.emit(air_state)


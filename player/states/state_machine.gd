class_name StateMachine
extends Node

@export var initial_state: PlayerState
var current_state: PlayerState = null
var _new_state: PlayerState = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is PlayerState:
			child.transition.connect(on_transition)
	
	if initial_state:
		on_transition(initial_state)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state.update(delta)
	
	
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
		
	if _new_state:
		if current_state:
			current_state.exit()
			
		current_state = _new_state
		_new_state = null
		current_state.enter()


# Get inputs from the keyboard and send them to the current state
func _unhandled_key_input(event):
	if current_state:
		current_state.handle_input(event)


# Checks if the player is able to move in the current state
func can_move() -> bool:
	if current_state:
		return current_state.can_move
		
	return false
	
func can_jump() -> bool:
	if current_state:
		return current_state.can_jump
		
	return false
	
	
func on_transition(new_state: PlayerState):
	_new_state = new_state

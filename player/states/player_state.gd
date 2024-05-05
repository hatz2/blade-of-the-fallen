class_name PlayerState
extends Node

signal transition(new_state: PlayerState)

@export var can_move := true
@export var can_jump := true
@export var animation_tree: AnimationTree

var playback: AnimationNodeStateMachinePlayback

func _ready():
	if animation_tree:
		playback = animation_tree["parameters/playback"]

func enter():
	pass
	
func exit():
	pass

func update(_delta):
	pass
	
func physics_update(_delta):
	pass
	
func handle_input(_event : InputEvent):
	pass


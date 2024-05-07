class_name PlayerState
extends State

@export var can_move := true
@export var can_jump := true
@export var animation_tree: AnimationTree

var playback: AnimationNodeStateMachinePlayback

func _ready():
	if animation_tree:
		playback = animation_tree["parameters/playback"]


class_name Idle
extends MonsterState

@export var walk_state: Walking
@export var idle_animation = "idle";
@onready var timer := $Timer
var swap_state = false

func _ready():
	pass

func enter():
	# Make the timer random
	swap_state = false
	var wait_time = randf_range(2.0, 4.0)
	timer.wait_time = wait_time
	animated_sprite.play(idle_animation)
	timer.start()
	
func exit():
	swap_state = false
	pass

func update(_delta):
	pass
	
func physics_update(_delta):
	if swap_state:
		transition.emit(walk_state)
	pass
	
func handle_input(_event : InputEvent):
	pass


func _on_timer_timeout():
	# Swap to walk state
	swap_state = true

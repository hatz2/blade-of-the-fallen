class_name Attacking
extends PlayerState

@export var attack_animation := "attack"
@export var second_attack_animation := "second_attack"
@export var ground_state: Ground
@onready var timer := $Timer

var use_first_attack := true

func enter():
	if use_first_attack: 
		playback.travel(attack_animation)
		use_first_attack = false
		timer.start()
	else:
		playback.travel(second_attack_animation)
		use_first_attack = true
	
func exit():
	pass


func update(_delta):
	pass
	
	
func physics_update(_delta):
	pass
	
	
func handle_input(_event : InputEvent):
	pass


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == attack_animation or anim_name == second_attack_animation:
		transition.emit(ground_state)


func _on_timer_timeout():
	use_first_attack = true

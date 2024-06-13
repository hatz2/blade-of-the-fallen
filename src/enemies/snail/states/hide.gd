extends MonsterState

@export var hide_animation := "hide"
@export var walk_state: State
@export var hurtbox_collision_shape: CollisionShape2D
@onready var timer := $Timer

func enter():
	hurtbox_collision_shape.disabled = true
	animated_sprite.play(hide_animation)
	timer.wait_time = randf_range(3.0, 6.0)
	timer.start()
	
func exit():
	hurtbox_collision_shape.disabled = false
	timer.stop()

func _on_timer_timeout():
	timer.stop()
	animated_sprite.play_backwards(hide_animation)
	await animated_sprite.animation_finished
	transition.emit(walk_state)

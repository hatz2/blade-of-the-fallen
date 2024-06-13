extends MonsterState

@export var attack_state: MonsterState

func enter():
	animated_sprite.play("hit")
	await animated_sprite.animation_finished
	animated_sprite.play("fly")
	transition.emit(attack_state)
	
func exit():
	pass

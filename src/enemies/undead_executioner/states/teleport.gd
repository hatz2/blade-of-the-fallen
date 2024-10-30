extends State

@export var follow_state: State
@onready var animation_player := $"../../AnimationPlayer"
@onready var sprite := $"../../Sprite2D"

func enter():
	animation_player.play("teleport")
	await animation_player.animation_finished
	transition.emit(follow_state)
	
func teleport():
	var sign = 1 if sprite.flip_h else -1
	var new_position = PlayerInstance.global_position
	new_position.x +=  40 * sign
	
	owner.global_position = new_position
	

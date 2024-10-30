extends State

const ATTACK_DISTANCE := 50
const TELEPORT_SUMMON_DISTANCE := 200
const TELEPORT_PROBABILITY := 0.5

@export var attack_state: State
@export var teleport_state: State
@export var summon_state: State
@onready var animation_player := $"../../AnimationPlayer"

func enter():
	var direction = PlayerInstance.global_position - owner.global_position as Vector2
	if direction.length() > ATTACK_DISTANCE and direction.length() < TELEPORT_SUMMON_DISTANCE:
		animation_player.play("idle")
	
	
func exit():
	owner.move_dir = Vector2.ZERO # Stop moving
	
	
func physics_update(_delta):
	var direction = PlayerInstance.global_position - owner.global_position as Vector2
	owner.move_dir = direction
	
	if direction.length() < ATTACK_DISTANCE:
		transition.emit(attack_state)
	elif direction.length() > TELEPORT_SUMMON_DISTANCE:
		var random_number = randf()
		
		if random_number > TELEPORT_PROBABILITY:
			transition.emit(summon_state)
		else:
			transition.emit(teleport_state)

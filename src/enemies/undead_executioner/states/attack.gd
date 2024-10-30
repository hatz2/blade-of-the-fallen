extends State

const ATTACK_LEAVE_DISTANCE := 80
@export var follow_state: State
@onready var hitbox := $"../../EnemyHitbox/CollisionShape2D"
@onready var animation_player := $"../../AnimationPlayer"
@onready var timer := $Timer
var can_attack := false
var can_transition := true

func enter():
	if can_attack:
		attack()
	
	
func update(_delta):
	if get_distance_from_player() < ATTACK_LEAVE_DISTANCE:
		if can_attack:
			attack()
		elif not animation_player.is_playing():
			animation_player.play("idle2")
	elif can_transition:
		transition.emit(follow_state)
	
func attack():
	can_attack = false
	can_transition = false
	animation_player.play("attacking")
	await animation_player.animation_finished
	can_transition = true
	timer.start()
	
func get_distance_from_player():
	var direction: Vector2 = PlayerInstance.global_position - owner.global_position
	return direction.length()


func _on_timer_timeout():
	can_attack = true

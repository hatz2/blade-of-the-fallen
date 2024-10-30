extends State

const UNDEAD_SUMMON_SCENE = preload("res://src/enemies/undead_summon/undead_summon.tscn")

@export var follow_state: State
@onready var animation_player := $"../../AnimationPlayer"
@onready var timer := $Timer
var can_transition = false

func enter():
	timer.stop()
	can_transition = false
	animation_player.play("summon")
	await animation_player.animation_finished
	animation_player.play("idle")
	timer.start()
	

	
func update(_delta):
	if can_transition:
		can_transition = false
		transition.emit(follow_state)
	
func summon():
	var entity = UNDEAD_SUMMON_SCENE.instantiate()
	var x = randf_range(-30, 30)
	var y = randf_range(-30, 30)
	entity.position = owner.position + Vector2(x, y)
	get_tree().current_scene.add_child(entity)
	

func _on_timer_timeout():
	can_transition = true

class_name Walking
extends MonsterState

@export var body: CharacterBody2D
@export var idle_state: Idle
@export var path_follow: PathFollow2D
@export var walk_animation := "walk"
@export var walk_speed := 10
@onready var timer := $Timer
var swap_state := false

func _ready():
	pass

func enter():
	swap_state = false
	animated_sprite.play(walk_animation)
	var wait_time = randf_range(4.0, 8.0)
	timer.wait_time = wait_time
	timer.start()
	
func exit():
	swap_state = false

func update(_delta):
	pass
	
func physics_update(delta):
	path_follow.progress = path_follow.progress + walk_speed * delta	
	
	if swap_state:
		transition.emit(idle_state)
	
func handle_input(_event : InputEvent):
	pass


func _on_timer_timeout():
	swap_state = true

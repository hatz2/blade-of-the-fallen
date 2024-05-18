class_name Walking
extends MonsterState

@export var edge_detection_area: Area2D
@export var wall_detection_area: Area2D
@export var body: CharacterBody2D
@export var idle_state: Idle
@export var walk_animation := "walk"
@export var walk_speed := 10
@export var moving_right := true
@onready var timer := $Timer
@onready var direction_timer := $DirectionSwapTimer


var swap_state := false

var _recently_swapped_direction := false

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
	body.velocity = Vector2.ZERO

func update(_delta):
	pass
	
func physics_update(delta):
	if moving_right:
		body.velocity.x = walk_speed
	else:
		body.velocity.x = -walk_speed
		
	# If we are on the edge or in a wall
	if body.is_on_floor():
		if (!edge_detection_area.has_overlapping_bodies() \
		or wall_detection_area.has_overlapping_bodies()) \
		and not _recently_swapped_direction:
			moving_right = not moving_right
			_recently_swapped_direction = true
			direction_timer.start()
	
	
	if swap_state:
		transition.emit(idle_state)
	
func handle_input(_event : InputEvent):
	pass


func _on_timer_timeout():
	swap_state = true


func _on_direction_swap_timer_timeout():
	_recently_swapped_direction = false

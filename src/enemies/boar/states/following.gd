class_name Following
extends MonsterState


@export var speed := 100
@export var follow_animation := "run"
@export var idle_animation := "idle"
@export var monster_body: CharacterBody2D
@export var hitbox_coll_shape: CollisionShape2D

const STOP_MOVE_DISTANCE := 15
var player: Player = null
var last_monster_pos: Vector2

func _ready():
	pass

func enter():
	last_monster_pos = monster_body.global_position
	animated_sprite.play(follow_animation)
	hitbox_coll_shape.disabled = false
	pass
	
func exit():
	hitbox_coll_shape.disabled = true
	pass

func update(_delta):
	pass
	
func physics_update(_delta):
	
	if not player:
		return
		
	var direction_to_move = player.global_position - monster_body.global_position
	
	var horizontal_distance = abs(player.global_position.x - monster_body.global_position.x)
	
	if horizontal_distance > STOP_MOVE_DISTANCE:
		monster_body.velocity.x = sign(direction_to_move.x) * speed
	else:
		monster_body.velocity.x = 0
		
	
	#if horizontal_distance < STOP_MOVE_DISTANCE: # we are not moving at all
		#animated_sprite.play(idle_animation)
	#else:
		#animated_sprite.play(follow_animation)
		
	last_monster_pos = monster_body.global_position
	
func handle_input(_event : InputEvent):
	pass


func _on_detection_area_body_entered(body):
	if body is Player:
		player = body

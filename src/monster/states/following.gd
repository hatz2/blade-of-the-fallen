class_name Following
extends MonsterState

var player: Player = null
@export var speed := 100
@export var follow_animation := "run"
@export var monster_body: CharacterBody2D

var last_monster_pos: Vector2

func _ready():
	pass

func enter():
	last_monster_pos = monster_body.global_position
	animated_sprite.play(follow_animation)
	pass
	
func exit():
	pass

func update(_delta):
	pass
	
func physics_update(_delta):
	
	if not player:
		return
		
	var direction_to_move = player.global_position - monster_body.global_position
	direction_to_move.y = 0
	direction_to_move = direction_to_move.normalized()
	
	monster_body.velocity = direction_to_move * speed
	
	if monster_body.global_position - last_monster_pos == Vector2.ZERO: # we are not moving at all
		animated_sprite.play("idle")
	else:
		animated_sprite.play(follow_animation)
		
	last_monster_pos = monster_body.global_position
	
func handle_input(_event : InputEvent):
	pass


func _on_detection_area_body_entered(body):
	if body is Player:
		player = body

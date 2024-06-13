extends MonsterState

@export var walk_state: Walking
@export var attack_area: Area2D
@export var attack_animation: String
@export var idle_animation: String
@onready var timer := $Timer
@onready var projectile := preload("res://src/enemies/bee/projectile/projectile.tscn")

var player_direction: Vector2

func _ready():
	timer.timeout.connect(_on_timer_timeout)

func enter():
	# attack
	if timer.paused:
		timer.paused = false
		
		if timer.time_left < 1:
			attack()
	else:
		attack()
	
func exit():
	timer.paused = true
	
func physics_update(_delta):
	if attack_area.has_overlapping_bodies():
		var player = attack_area.get_overlapping_bodies().front() as Player
		player_direction = owner.global_position - player.global_position
		
		if player_direction.x > 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
	else:
		transition.emit(walk_state)
	
func handle_input(_event : InputEvent):
	pass
	
func attack():
	animated_sprite.stop()
	animated_sprite.play(attack_animation)
	await animated_sprite.animation_finished
	animated_sprite.play(idle_animation)
	
	# Send projectile
	shoot()
	
	# Restart timer
	timer.start()
	
func shoot():
	var instance = projectile.instantiate()
	instance.global_position = owner.global_position
	instance.global_rotation = Vector2.LEFT.angle_to(player_direction)
	get_tree().get_root().add_child(instance)


func _on_timer_timeout():
	attack()

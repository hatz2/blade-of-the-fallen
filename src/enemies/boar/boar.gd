class_name Boar
extends CharacterBody2D


const DAMAGE_INDICATOR = preload("res://src/ui/damage_indicator/damage_indicator.tscn")
const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var moving_right: bool = true
@onready var sprite := $AnimatedSprite2D
@onready var edge_detection_shape := $EdgeDetectionArea/CollisionShape2D
@onready var wall_detection_shape := $WallDetectionArea/CollisionShape2D
@onready var player_detection_shape := $PlayerDetectionArea/CollisionShape2D

func _ready():
	$StateMachine/Walking.moving_right = moving_right

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	update_sprite_orientation()
	move_and_slide()
	
func update_sprite_orientation():
	var last_sprite_flip_h = sprite.flip_h
	
	if get_last_motion().x < 0:
		sprite.flip_h = false
	elif get_last_motion().x > 0:
		sprite.flip_h = true
		
	# Update collision shapes orientation if the sprite orientation changed
	if sprite.flip_h != last_sprite_flip_h:
		edge_detection_shape.position.x *= -1
		player_detection_shape.position.x *= -1
		wall_detection_shape.position.x *= -1

func _on_health_dead():
	set_physics_process(false)
	queue_free()


func _on_hurtbox_hit(damage: int):
	var previous_anim = sprite.animation
	sprite.play("hit")
	
	# Spawn damage number object
	var indicator = DAMAGE_INDICATOR.instantiate()
	indicator.global_position = $DamagePosition.global_position
	indicator.damage_number = damage
	get_tree().current_scene.add_child(indicator)
	
	await sprite.animation_finished
	sprite.play(previous_anim)

class_name Bee
extends CharacterBody2D

const SPEED = 200.0

@export var moving_right: bool = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $AnimatedSprite2D
@onready var edge_detection_shape := $FloorDetector/CollisionShape2D
@onready var wall_detection_shape := $WallDetector/CollisionShape2D


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
		wall_detection_shape.position.x *= -1


func _on_health_dead():
	set_physics_process(false)
	queue_free()

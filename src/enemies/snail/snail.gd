extends CharacterBody2D

const DAMAGE_INDICATOR = preload("res://src/ui/damage_indicator/damage_indicator.tscn")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $AnimatedSprite2D
@onready var edge_detection_shape := $FloorDetector/CollisionShape2D
@onready var wall_detection_shape := $WallDetector/CollisionShape2D
@export var moving_right: bool = true

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
	$StateMachine/Hide/Timer.stop()
	$EnemyHurtbox/CollisionShape2D.disabled = true
	$StateMachine.on_transition($StateMachine/Dead)
	$AnimatedSprite2D.play("dead")
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_enemy_hurtbox_hit(damage: int):
	var indicator = DAMAGE_INDICATOR.instantiate()
	indicator.damage_number = damage
	print(indicator.global_position)
	indicator.global_position = $DamagePosition.global_position
	get_tree().current_scene.add_child(indicator)

class_name Player
extends CharacterBody2D

signal player_died()

const SPEED = 300.0
const JUMP_VELOCITY = -325.0
const DAMAGE_INDICATOR = preload("res://src/ui/damage_indicator/damage_indicator.tscn")
const REWARD_INDICATOR = preload("res://src/ui/reward_indicator/reward_indicator.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite := %Sprite2D
@onready var playback: AnimationNodeStateMachinePlayback = %AnimationTree.get("parameters/playback")
@onready var state_machine: StateMachine = %StateMachine
@onready var hit_area_col_shape: CollisionShape2D = %HitboxShape
@onready var health := $Health
@onready var attack := $Attack

var coins := 0

func _ready():
	Events.update_player_position.connect(func(pos: Vector2): global_position = pos)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() \
	and state_machine.can_jump():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("run_left", "run_right")
	if direction and state_machine.can_move():
		velocity.x = direction * SPEED
		# Update sprite direction
		var sprite_last_orientation = sprite.flip_h
		sprite.flip_h = direction == -1
		_update_hit_box_orientation(sprite_last_orientation)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
func _update_hit_box_orientation(last_sprite_orientation: bool):
	if last_sprite_orientation != sprite.flip_h:
		hit_area_col_shape.position.x = hit_area_col_shape.position.x * -1
		
		
		
func restart():
	playback.start("start")
	%StateMachine.on_transition($StateMachine/Ground)
	health.MAX_HEALTH = 80
	health.health = 80
	attack.damage = 20
	$Hurtbox/CollisionShape2D.disabled = false


func die():
	%StateMachine.on_transition($StateMachine/Dead)
	set_physics_process(false)
	$Hurtbox/CollisionShape2D.disabled = true
	await %AnimationTree.animation_finished
	get_tree().reload_current_scene()
	restart()

	
func _on_health_dead():
	die()


func _on_hurtbox_hit(damage):
	var indicator = DAMAGE_INDICATOR.instantiate()
	indicator.damage_number = damage
	indicator.global_position = $DamagePosition.global_position
	indicator.color = Color(1.0, 0.0, 0.0, 1.0)
	get_tree().current_scene.add_child(indicator)
	
func health_reward():
	make_reward_indicator("+20 Max health\n+50 Health")
	health.MAX_HEALTH += 20
	health.increase_current_health(50)
	
	
func attack_reward():
	make_reward_indicator("+10 Damage")
	attack.damage += 10
	
func coins_reward():
	make_reward_indicator("+50 Coins")
	coins += 50
	
func make_reward_indicator(text: String):
	var indicator = REWARD_INDICATOR.instantiate()
	indicator.global_position = $RewardIndicatorPosition.global_position
	indicator.text = text
	get_tree().current_scene.add_child(indicator)
	return indicator
	

class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -325.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite := $Sprite2D
@onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var state_machine: StateMachine = $StateMachine
@onready var hit_area_col_shape: CollisionShape2D = %HitboxShape

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

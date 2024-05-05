class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite := $Sprite2D
@onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var state_machine: StateMachine = $StateMachine

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
		sprite.flip_h = direction == -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _process(delta):
	pass


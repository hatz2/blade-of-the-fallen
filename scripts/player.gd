class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite := $Sprite2D
@onready var playback : AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func handle_input():
	
	if not is_on_floor():
		return
		
	if Input.is_action_just_pressed("jump"):
		playback.travel("jump")
		return
	
	if Input.is_action_just_pressed("attack"):
		playback.travel("attack")
		return
		
	if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		playback.travel("run")
		return
		
	playback.travel("idle")

func _physics_process(delta):
	handle_input()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("run_left", "run_right")
	print(direction)
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction == -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _process(delta):
	pass


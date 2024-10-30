extends CharacterBody2D

const DAMAGE_INDICATOR = preload("res://src/ui/damage_indicator/damage_indicator.tscn")
const SPEED := 50

@onready var hitbox_collision_shape := $EnemyHitbox/CollisionShape2D
@onready var sprite := $Sprite2D
@onready var animation_player := $AnimationPlayer
@onready var state_machine := $StateMachine
@onready var dead_state := $StateMachine/Dead
var move_dir: Vector2 = Vector2.ZERO

func _ready():
	Globals.background_music_sound_player.stop()
	update_life_bar()
	

func _process(_delta):
	update_orientation()
	update_life_bar()


func _physics_process(_delta):
	velocity = move_dir.normalized() * SPEED
	move_and_slide()
	
	
func update_orientation():
	if move_dir.x > 0:
		sprite.flip_h = false
		hitbox_collision_shape.position.x = abs(hitbox_collision_shape.position.x)
	elif move_dir.x < 0:
		sprite.flip_h = true
		hitbox_collision_shape.position.x = -abs(hitbox_collision_shape.position.x)


func _on_health_dead():
	set_physics_process(false)
	state_machine.on_transition(dead_state)
	animation_player.play("death")
	hitbox_collision_shape.disabled = true
	await animation_player.animation_finished
	queue_free()
	Globals.background_music_sound_player.volume_db -= 10
	
func update_life_bar():
	$CanvasLayer/ProgressBar.max_value = $Health.MAX_HEALTH
	$CanvasLayer/ProgressBar.value = $Health.health


func _on_enemy_hurtbox_hit(damage):
	var indicator = DAMAGE_INDICATOR.instantiate()
	indicator.global_position = $DamagePosition.global_position
	indicator.damage_number = damage
	get_tree().current_scene.add_child(indicator)

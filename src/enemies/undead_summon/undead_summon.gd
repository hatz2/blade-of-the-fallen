extends CharacterBody2D

const DAMAGE_INDICATOR = preload("res://src/ui/damage_indicator/damage_indicator.tscn")
const SPEED := 100

@onready var animation_player := $AnimationPlayer
@onready var hurtbox := $EnemyHurtbox/CollisionShape2D

func _ready():
	hurtbox.disabled = true
	set_physics_process(false)
	animation_player.play("appear")
	await animation_player.animation_finished
	hurtbox.disabled = false
	set_physics_process(true)
	animation_player.play("idle")
	

func _physics_process(delta):
	var direction: Vector2 = PlayerInstance.global_position - global_position
	velocity = direction.normalized() * SPEED
	move_and_slide()


func _on_health_dead():
	hurtbox.disabled = true
	set_physics_process(false)
	animation_player.play("death")
	await animation_player.animation_finished
	queue_free()


func _on_enemy_hurtbox_hit(damage):
	var indicator = DAMAGE_INDICATOR.instantiate()
	indicator.global_position = $DamagePosition.global_position
	indicator.damage_number = damage
	get_tree().current_scene.add_child(indicator)

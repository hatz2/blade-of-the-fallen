class_name BeeProjectile
extends CharacterBody2D

@export var speed := 100
	
func _physics_process(delta):
	var motion = Vector2(speed, 0).rotated(global_rotation) * delta
	var collision := move_and_collide(motion)
	
	if collision:
		queue_free()


func _on_hitbox_area_entered(area: PlayerHurtbox):
	queue_free()

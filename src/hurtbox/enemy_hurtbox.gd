class_name EnemyHurtbox
extends Area2D

signal hit(damage: int)

@export var health: Health

func _init():
	collision_layer = 32
	collision_mask = 0

func take_damage(attack: Attack):
	if health.health > 0:
		health.damage(attack)
		hit.emit(attack.damage)
		
		var direction = owner.global_position - attack.owner.global_position as Vector2
		var knockback = Vector2(sign(direction.x), 0)
		knockback *= attack.knockback
		owner.global_position += knockback

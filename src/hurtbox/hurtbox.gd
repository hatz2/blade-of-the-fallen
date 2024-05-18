class_name Hurtbox
extends Area2D

@export var health: Health

func _init():
	collision_layer = 8
	collision_mask = 0

func take_damage(attack: Attack):
	if health:
		health.damage(attack)

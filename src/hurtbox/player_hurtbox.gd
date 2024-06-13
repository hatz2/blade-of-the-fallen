class_name PlayerHurtbox
extends Area2D

signal hit()

@export var health: Health

func _init():
	collision_layer = 8
	collision_mask = 0

func take_damage(attack: Attack):
	if health:
		health.damage(attack)
		hit.emit()

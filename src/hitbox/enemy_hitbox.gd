class_name EnemyHitbox
extends Area2D

@export var attack: Attack

func _init():
	collision_layer = 0
	collision_mask = 8 # Player hurtbox
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hurtbox: PlayerHurtbox):
	hurtbox.take_damage(attack)


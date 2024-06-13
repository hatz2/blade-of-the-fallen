class_name PlayerHitbox
extends Area2D

@export var attack: Attack

func _init():
	collision_layer = 0
	collision_mask = 32 # Enemy hurtbox mask
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hurtbox: EnemyHurtbox):
	hurtbox.take_damage(attack)
	
	# Apply knockback
	

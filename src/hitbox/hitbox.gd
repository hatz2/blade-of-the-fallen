class_name Hitbox
extends Area2D

const HITBOX_LAYER := 8

@export var attack: Attack

func _init():
	collision_layer = 0
	collision_mask = HITBOX_LAYER
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hurtbox: Hurtbox):
	hurtbox.take_damage(attack)


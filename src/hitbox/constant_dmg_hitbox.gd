class_name ConstantDmgHitbox
extends EnemyHitbox

func _init():
	super._init()
	collision_mask = 8 # Player hurtbox
	disconnect("area_entered", _on_area_entered)

func _on_timer_timeout():
	var areas: Array[Area2D] = get_overlapping_areas()
	
	for area in areas:
		if area is PlayerHurtbox:
			area.take_damage(attack)

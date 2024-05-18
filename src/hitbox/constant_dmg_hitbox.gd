class_name ConstantDmgHitbox
extends Hitbox

func _init():
	super()
	disconnect("area_entered", _on_area_entered)

func _on_timer_timeout():
	var bodies: Array[Area2D] = get_overlapping_areas()
	
	for body in bodies:
		if body is Hurtbox and body.owner != owner:
			body.take_damage(attack)

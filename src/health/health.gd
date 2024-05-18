class_name Health
extends Node

@export var MAX_HEALTH: int = 100
var health: int

signal dead()

func _ready():
	health = MAX_HEALTH

func damage(attack: Attack):
	health -= attack.damage
	
	if health <= 0:
		# Delete the object
		#get_parent().queue_free()
		
		# We can instead send a signal of death
		dead.emit()

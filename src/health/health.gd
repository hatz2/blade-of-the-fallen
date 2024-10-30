class_name Health
extends Node

@export var MAX_HEALTH: int = 100
var health: int

signal dead()

func _ready():
	health = MAX_HEALTH

func damage(attack: Attack):
	health -= attack.damage
	
	health = max(health, 0)
	
	if health <= 0:
		dead.emit()
		
		
func increase_current_health(increased_health: int):
	var new_health = health + increased_health
	health = min(MAX_HEALTH, new_health)

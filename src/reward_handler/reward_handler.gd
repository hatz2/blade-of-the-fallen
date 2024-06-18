class_name RewardHandler
extends Node

signal go_to_next_level()

const CHEST_SCENE = preload("res://src/chest/chest.tscn")
const CHEST_SCRIPT = preload("res://src/chest/chest.gd")

@export var first_chest_pos: Marker2D
@export var second_chest_pos: Marker2D

@onready var next_level_timer := $NextLevelTimer

var first_chest: Chest
var second_chest: Chest
var reward_obtained := false


# Called when the node enters the scene tree for the first time.
func _ready():
	# Instantiate the chest scenes
	first_chest = CHEST_SCENE.instantiate()
	second_chest = CHEST_SCENE.instantiate()
	
	# Choose rewards randomly
	var rewards: Array = [CHEST_SCRIPT.Reward.DAMAGE, CHEST_SCRIPT.Reward.HEALTH, CHEST_SCRIPT.Reward.COINS]
	rewards.shuffle()
	first_chest.reward_type = rewards[0]
	first_chest.reward_type = rewards[1]
	
	# Connect their open signal
	first_chest.chest_opened.connect(on_reward_selected)
	second_chest.chest_opened.connect(on_reward_selected)
	
	# Move them to the correct position
	first_chest.global_position = first_chest_pos.global_position
	second_chest.global_position = second_chest_pos.global_position
	
	# Add both chests as children
	get_tree().current_scene.add_child(first_chest)
	get_tree().current_scene.add_child(second_chest)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func on_level_completed():
	# Enable the chests
	first_chest.enable()
	second_chest.enable()
	
func on_reward_selected(reward: CHEST_SCRIPT.Reward):
	if reward_obtained:
		return
	
	reward_obtained = true
	next_level_timer.start()
		
	# Disable the chests
	first_chest.delete()
	second_chest.delete()
		
	# Apply the reward
	print("Reward obtained", reward) 
	
	


func _on_next_level_timer_timeout():
	go_to_next_level.emit()

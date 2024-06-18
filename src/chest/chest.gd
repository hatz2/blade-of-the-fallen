class_name Chest
extends Node2D

signal chest_opened(reward: Reward)

enum Reward {
	DAMAGE,
	HEALTH,
	COINS
}

const DESCRIPTIONS: Dictionary = {
	Reward.DAMAGE: "Increases your damage by 10",
	Reward.HEALTH: "Increases your max health by 20 and restores 50 health",
	Reward.COINS: "Obtain 50 coins",
}

@onready var sprites: Dictionary = {
	Reward.DAMAGE: $AttackRewardSprite,
	Reward.HEALTH: $HealthRewardSprite,
	Reward.COINS: $CoinRewardSprite,
}

@export var reward_type: Reward
@onready var label := $DescriptionPanel/Label
@onready var area := $Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = DESCRIPTIONS[reward_type]
	sprites[reward_type].visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if area.has_overlapping_bodies() and not $DescriptionPanel.visible:
		$DescriptionAnimationPlayer.play("appear")
	elif not area.has_overlapping_bodies() and $DescriptionPanel.visible:
		$DescriptionAnimationPlayer.play_backwards("appear")
	
func _input(event):
	if area.has_overlapping_bodies() and event.is_action_pressed("attack"):
		$ChestAnimationPlayer.play("open")
		await $ChestAnimationPlayer.animation_finished
		chest_opened.emit(reward_type)
	
func enable():
	$ChestAnimationPlayer.play("appear")
	sprites[reward_type].visible = true
	
func delete():
	$ChestAnimationPlayer.play_backwards("appear")
	await $ChestAnimationPlayer.animation_finished
	queue_free()
	


extends Node2D

@export var player: Player

func _physics_process(_delta):
	%Label.text = str(player.coins)

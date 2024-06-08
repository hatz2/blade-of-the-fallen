class_name FallDeathZone
extends Area2D

func _ready():
	collision_layer = 0
	collision_mask = 2 | 4
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body is Player:
		var player = body as Player
		player.die()
	else:
		body.queue_free()

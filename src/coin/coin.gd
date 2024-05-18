extends Area2D


func _on_body_entered(body):
	if body is Player:
		# Increase the amount of coins the player has
		var player = body as Player
		player.coins += 1
		# Delete this object
		queue_free()

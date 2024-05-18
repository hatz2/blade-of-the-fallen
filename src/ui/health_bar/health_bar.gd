extends ProgressBar

@export var health: Health

func _process(delta):
	# Update value
	value = health.health
	max_value = health.MAX_HEALTH
	$Label.text = str(value) + " / " + str(max_value)

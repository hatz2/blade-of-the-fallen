extends ProgressBar

func _physics_process(_delta):
	# Update value
	var health = PlayerInstance.get_node("Health") as Health
	value = health.health
	max_value = health.MAX_HEALTH
	$Label.text = str(value) + " / " + str(max_value)

extends Walking

func _ready():
	super()
	timer.timeout.disconnect(_on_timer_timeout)

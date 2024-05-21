extends Camera2D

func _ready():
	CameraLimiter.update_limits.connect(on_update_limits)

func on_update_limits(left: int, right: int, top: int, bottom: int):
	limit_left = left
	limit_right = right
	limit_top = top
	limit_bottom = bottom

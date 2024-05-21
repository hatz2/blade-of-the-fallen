class_name BaseLevel
extends TileMap

@export var player_initial_position: Marker2D

func _ready():
	var area: Rect2i = get_used_rect()
	print(area)
	var cell_size = tile_set.tile_size
	
	var left: int = area.position.x * cell_size.x
	var right: int = area.end.x * cell_size.x
	var top: int = area.position.y * cell_size.y
	var bottom: int = area.end.y * cell_size.y
	
	print(left)
	print(right)
	print(top)
	print(bottom)
	
	CameraLimiter.update_limits.emit(left, right, top, bottom)

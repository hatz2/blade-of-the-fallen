class_name BaseLevel
extends TileMap

signal change_level(level_path: String)

@export var player_initial_position: Marker2D
@export var next_scene_path: String

func _ready():
	var area: Rect2i = get_used_rect()
	var cell_size = tile_set.tile_size
	
	var left: int = area.position.x * cell_size.x
	var right: int = area.end.x * cell_size.x
	var top: int = area.position.y * cell_size.y
	var bottom: int = area.end.y * cell_size.y
	
	CameraLimiter.update_limits.emit(left, right, top, bottom)
	
	# Set the player position
	PlayerInstance.global_position = player_initial_position.global_position
	#Events.update_player_position.emit(player_initial_position.global_position)

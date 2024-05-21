class_name InitialMap
extends BaseLevel

func _ready():
	super()
	$Player.global_position = $PlayerPos.global_position

func _on_fall_area_body_entered(body: Player):
	# TODO: Change to first level scene
	print("Player felt")

extends State

@export var follow_state: State
@onready var player_detector_collision_shape := $"../../PlayerDetector/CollisionShape2D"
@onready var animation_player := $"../../AnimationPlayer"
@onready var health_bar := $"../../CanvasLayer/ProgressBar"

func _ready():
	animation_player.play("idle2")
	player_detector_collision_shape.disabled = true

func enter():
	player_detector_collision_shape.disabled = false
	
func exit():
	player_detector_collision_shape.disabled = true
	health_bar.visible = true
	Globals.background_music_sound_player.stop()
	Globals.background_music_sound_player.stream = preload("res://assets/sounds/66. The Final Battle.mp3")
	Globals.background_music_sound_player.play()


func _on_player_detector_body_entered(body: Player):
	transition.emit(follow_state)

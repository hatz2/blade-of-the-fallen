extends Node

@onready var coin_sound_player := AudioStreamPlayer.new()
@onready var background_music_sound_player := AudioStreamPlayer.new()

# Se ejecuta cuando el nodo entra en la escena por primera vez
func _ready():
	coin_sound_player.bus = "SFX"
	coin_sound_player.stream = preload("res://assets/sounds/collect-coin.mp3") as AudioStream
	add_child(coin_sound_player)
	
	background_music_sound_player.bus = "Music"
	add_child(background_music_sound_player)


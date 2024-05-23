extends Node

@onready var coin_sound_player: AudioStreamPlayer = AudioStreamPlayer.new()

# Se ejecuta cuando el nodo entra en la escena por primera vez
func _ready():
	coin_sound_player.stream = preload("res://assets/sounds/collect-coin.mp3") as AudioStream
	add_child(coin_sound_player)


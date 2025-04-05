extends Node2D

var sounds = {
	"quack_01": preload("res://sounds/quack_01.mp3"),
	"quack_02": preload("res://sounds/quack_02.mp3"),
	"sword_opening": preload("res://sounds/sword_opening.mp3"),
	"game_starts": preload("res://sounds/game_starts.mp3")
}



func play_quack(position: Vector2):
		var audio_player = AudioStreamPlayer2D.new()
		var sound_name = "quack_01" # Fallback
		
		if randf() > 0.5:
			sound_name = "quack_02"
			
		audio_player.stream = sounds[sound_name]
		audio_player.position = position  # Attach sound to NPC's position
		add_child(audio_player)
		audio_player.play()
		audio_player.connect("finished", audio_player.queue_free)  # Cleanup when done

func play_sound(sound_name: String):
		var audio_player = AudioStreamPlayer2D.new()
		
		audio_player.stream = sounds[sound_name]
		add_child(audio_player)
		audio_player.play()
		audio_player.connect("finished", audio_player.queue_free)  # Cleanup when done

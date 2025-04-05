extends Node2D

#var hud_scene = preload("res://scenes/hud.tscn")

@onready var character_manager = $CharacterManager  # Reference the CharacterManager
var character_scene = preload("res://scenes/duck.tscn")

@onready var audio_manager = get_node("/root/Main/AudioManager")  # Adjust path


# Called when the node enters the scene tree for the first time.
func _ready():
	audio_manager.play_sound("game_starts")
	#var hud = hud_scene.instantiate()
	#add_child(hud)  # Make sure it's on top of everything

func add_character():
	var parent = get_node("/root/Main/GameContainer/Duckland/Pond")  # Adjust path as needed
	var new_character = character_manager.add_character(parent, character_scene)
	print("Added new character: " + new_character.name)

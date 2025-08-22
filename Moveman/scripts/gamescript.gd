extends Node2D

#var hud_scene = preload("res://scenes/hud.tscn")

@onready var character_manager = $CharacterManager  # Reference the CharacterManager


@onready var audio_manager = get_node("/root/Main/AudioManager")  # Adjust path

@onready var data_manager

var map = preload("res://scenes/maploader_holder.tscn").instantiate()

#GAME VARIABLES (GLOBAL?)
var duck_cost = 8

var pool_manager = preload("res://scripts/multi_entity_pool.gd").new()

func _ready():
	data_manager = get_tree().get_root().get_node("Main/DataManager")
	
	audio_manager.play_sound("game_starts")
	
	add_child(map)

	print("Map children: ", get_tree().get_root().find_child("Maploader_holder", true, false))
	
	
	pool_manager.register_scene("res://scenes/duck.tscn", 10)
	
	

	#add_child(hud)  # Make sure it's on top of everything
	
	#print_tree_pretty()

func add_character():
	if duck_cost <= data_manager.get_value_on_resource("food"):
		var parent = get_node("/root/Main/GameContainer/Duckland/Spring")  # Adjust path as needed
		var new_character = character_manager.add_character(parent, "duck", pool_manager.get_entity("res://scenes/duck.tscn"))
		print("Added new character: " + new_character.name)
		
		data_manager.set_value_on_resource("food", data_manager.get_value_on_resource("food") - 8)

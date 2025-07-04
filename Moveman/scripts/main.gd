extends Node2D

@onready var game_container = $GameContainer  # A dedicated node for game scenes
@onready var audio_manager = get_node("/root/Main/AudioManager")  # Adjust path



func _ready():
	await get_tree().create_timer(2).timeout
	audio_manager.play_sound("sword_opening")
	await get_tree().create_timer(0.5).timeout
	

	load_scene("res://scenes/loading_screen.tscn")  # Load the loading screen first

func _on_level_loaded(level):
	$CanvasLayer/HUD.visible = true

func load_scene(scene_path):
	# Remove any previous scene inside GameContainer
	for child in game_container.get_children():
		child.queue_free()
	
	var new_scene = load(scene_path).instantiate()
	

		
	game_container.add_child(new_scene)
	
	if new_scene.has_signal("level_loaded"):
		new_scene.connect("level_loaded", Callable(self, "_on_level_loaded"))
	
	await get_tree().process_frame  # Ensure the new scene starts initializing
	await new_scene.ready  # Wait until `_ready()` is fully executed

	# Now that the scene is confirmed loaded, mark as ready
	print("Scene loaded successfully:", scene_path)
	get_tree().get_root().get_node("Main/LoadingManager").mark_loaded()



extends Node2D

@export var progress_bar: ProgressBar
@onready var main_scene = get_tree().get_first_node_in_group("main_scene") 

var path = "res://scenes/duckland.tscn"
var loaded_scene : PackedScene = null
var load_progress = [0.0]

signal level_loaded(new_signal)

func _ready():
	ResourceLoader.load_threaded_request(path)


	

func _process(delta):
	var status = ResourceLoader.load_threaded_get_status(path, load_progress)
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		progress_bar.value = load_progress[0] * 100
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		loaded_scene = ResourceLoader.load_threaded_get(path)
		progress_bar.value = 100
		print("Duckland Scene Loaded!") 
		
		await get_tree().create_timer(1).timeout
		
		# Remove loading screen
		queue_free()

		# Load game scene inside the main scene's GameContainer
		main_scene.load_scene(path)
		
		emit_signal("level_loaded", true)

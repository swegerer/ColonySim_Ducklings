extends Node2D

@export var chunk_size: Vector2 = Vector2(3240, 3240) # Größe eines Map-PNGs in Pixeln
@export var map_folder: String = "res://sprites/Map_Squares/"       # Ordner mit Map_x_y.png
@export var load_distance: float = 10000.0             # Wann Chunk geladen wird

var chunks = {}   # Dictionary: "x_y" -> {pos: Vector2, path: String, node: Sprite2D}
var player_ref: Node2D

func _ready():
	player_ref = get_node_or_null("/root/Main/CameraMain")
	if not player_ref:
		push_warning("Kein Player gefunden unter /root/World/Player – bitte anpassen!")

	load_chunk_metadata()
	spawn_empty_placeholders()

func load_chunk_metadata():
	var dir = DirAccess.open(map_folder)
	if dir:
		dir.list_dir_begin()
		var file = dir.get_next()
		while file != "":
			if file.ends_with(".png") and file.begins_with("Map_"):
				var parts = file.trim_prefix("Map_").trim_suffix(".png").split("_")
				if parts.size() == 2:
					var x = int(parts[0])
					var y = int(parts[1])
					# Y inverted, because Godot's coordinate system grows downwards
					var pos = Vector2(x * chunk_size.x, -y * chunk_size.y)
					var key = str(x) + "_" + str(y)
					chunks[key] = {
						"pos": pos,
						"path": map_folder + file,
						"node": null
					}
			file = dir.get_next()
		dir.list_dir_end()

func spawn_empty_placeholders():
	for key in chunks.keys():
		var placeholder = Node2D.new()
		placeholder.position = chunks[key].pos
		add_child(placeholder)
		chunks[key].node = placeholder

func _process(_delta):
	if not player_ref:
		return
	var player_pos = player_ref.get_screen_center_position()
	for key in chunks.keys():
		var data = chunks[key]
		var dist = player_pos.distance_to(data.pos)
		if dist < load_distance and data.node.get_child_count() == 0:
			load_chunk_texture(data)
		elif dist >= load_distance and data.node.get_child_count() > 0:
			unload_chunk_texture(data)

func load_chunk_texture(data):
	var sprite = Sprite2D.new()
	sprite.texture = load(data.path)
	sprite.position = Vector2.ZERO
	sprite.centered = false
	data.node.add_child(sprite)

func unload_chunk_texture(data):
	for c in data.node.get_children():
		c.queue_free()
	

extends CharacterBody2D

@export var fsm: Node  # Assign FSM node in the editor
#@export var pond: Node  # Assign in the editor when spawning
var known_locations: Array[Node] = []

@onready var hover_area = $HoverArea2D
@onready var info_box = $Infobox
@onready var sense_area = $SensesArea2D

@export var camera_button: Button

@onready var camera_duck = get_tree().current_scene.find_child("CameraDuck", true, false)

@export var sprite_Duckbody: Sprite2D
@export var sprite_Frontwheel: Sprite2D
@export var sprite_Backwheel: Sprite2D


@export var progress_bar: ProgressBar


var is_hovered = false
signal update_data
var lock_ui = false

var data_manager


var tilemap_fog


var currently_visible_tiles: Array[Vector2i] = []
var visible_tile_counter: Dictionary = {}

var time_since_last_fog_check = 0

var inventory := Inventory.new()

func _ready():
	progress_bar.visible = false
	
	data_manager = get_tree().get_root().get_node("Main/DataManager")
	tilemap_fog = get_tree().get_root().get_node("Main/GameContainer/Duckland/Fog/Tilemap_Fog")
	
	hover_area.shape_size = Vector2(70, 70)
	hover_area.connect("hovered", _on_hover)
	hover_area.connect("unhovered", _on_unhover)
	hover_area.connect("clicked", _on_click)
	changed_Info()
	
	data_manager.change_max_on_resource("food", 20)

func update_sprites():
	if velocity.x > 0:
		sprite_Duckbody.flip_h = true
	elif velocity.x < 0:
		sprite_Duckbody.flip_h = false
	# Update wheel rotations
	sprite_Frontwheel.rotation += velocity.length() * 0.1
	sprite_Backwheel.rotation += velocity.length() * 0.1

func show_progress():
	progress_bar.value = 0
	progress_bar.visible = true

func hide_progress():
	progress_bar.visible = false

func update_progress(value: float):
	progress_bar.value = clamp(value, 0, progress_bar.max_value)
	
	
func _process(delta):
	update_sprites()

func changed_Info():
	update_data.emit()
	

func _on_hover(area):
	is_hovered = true
	camera_button.visible = true
	info_box.show()
	#info_box.text = area.hover_info

func _on_unhover(area):
	is_hovered = false
	await get_tree().create_timer(2.0).timeout  # Wait 1 second
	if not is_hovered and not lock_ui:
		camera_button.visible = false
		info_box.hide()
		
		
func _on_click(area):
	u_lock_ui()
	
		


func focus_camera_on(colider):
	camera_duck.follow(self)
	camera_duck.set_sideview()
	camera_duck.toggle_camera()
	
	
	
	
func u_lock_ui():
	if lock_ui == false:
		lock_ui = true
	else:
		lock_ui = false

func _physics_process(delta):
	if fsm and fsm.current_state:
		fsm.current_state.update(delta)  # Call the current state's update function

	move_and_slide()  # Always apply velocity after state logic
	
	if get_slide_collision_count() > 0:
		if fsm and fsm.current_state.has_method("on_collision"):
			fsm.current_state.on_collision()
			
	if sense_area.get_overlapping_bodies().has(self):
		reveal_fog()
		

	
	
func exchange_locations(pond_node):
	# Get pond's discovered locations
	var pond_locations = pond_node.discovered_locations
	
	# Add missing locations to pond's list
	for loc in known_locations:
		if loc not in pond_locations:
			pond_node.register_location(loc)
	
	# Add missing locations from pond's list to own list
	for loc in pond_locations:
		if loc not in known_locations:
			known_locations.append(loc)
			
	changed_Info()
	
func stop_movement():
	velocity = Vector2(0, 0)
	
func has_item():
	return !inventory.is_empty()

func unload_to_base(spring_node):
	var item = inventory.remove(0)
	
	if item:
		if item.name == "food":
			data_manager.set_value_on_resource("food", data_manager.get_value_on_resource("food") + item.amount)

func reveal_fog():
	currently_visible_tiles.clear()
	var collision_shape = sense_area.get_node("CollisionSenses") as CollisionShape2D
	
	var circle_shape = collision_shape.shape as CircleShape2D
	if circle_shape == null:
		print("Not a circle shape.")
		return

	var radius = circle_shape.radius
	var area_pos = sense_area.global_position
	var tile_size = tilemap_fog.tile_set.tile_size

	var min_x = floor((area_pos.x - radius) / tile_size.x)
	var max_x = ceil((area_pos.x + radius) / tile_size.x)
	var min_y = floor((area_pos.y - radius) / tile_size.y)
	var max_y = ceil((area_pos.y + radius) / tile_size.y)


	for x in range(min_x, max_x):
		for y in range(min_y, max_y):
			var tile_pos = Vector2i(x, y)
			var tile_world_pos = Vector2(tile_pos.x, tile_pos.y) * Vector2(tile_size.x, tile_size.y)

			tile_world_pos.x += tile_size.x / 2
			tile_world_pos.y += tile_size.y / 2
			
			# Check if within circle radius
			if area_pos.distance_to(tile_world_pos) <= radius:
				
				if tilemap_fog.get_cell_tile_data(0, tile_pos) != null:
					tilemap_fog.set_cell(0, tile_pos, -1)
					currently_visible_tiles.append(tile_pos)
					visible_tile_counter[tile_pos] = visible_tile_counter.get(tile_pos, 0) + 1
					


func get_gathering_modifier():
	return 0

extends Node2D

@export var duck_camera: Camera2D  # The camera this listens for

@export var canvas: CanvasLayer
var WINDOW_SCENE_PATH = "res://scenes/sidewindow.tscn"

var duck_window: Node = null
var current_duck

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		close_duck_window()
	if event.is_action_pressed("ui_down"):
		close_duck_window()
	if event.is_action_pressed("ui_left"):
		close_duck_window()
	if event.is_action_pressed("ui_right"):
		close_duck_window()
		
	if event.is_action_pressed("escape"):
		close_duck_window()

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:		
		handle_double_click(get_global_mouse_position())
		
func handle_double_click(pos: Vector2):
	var space_state = get_world_2d().direct_space_state
	

	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collide_with_bodies = false  # Or true if ducks are also bodies
	query.collision_mask = 0xFFFFFFFF

	var hits = space_state.intersect_point(query, 5)

	for hit in hits:
		var node = hit.collider
		while node:
			if node.is_in_group("ducks"):
				current_duck = node
				node.focus_camera_on(node)
				open_duck_window()
				
				return
			node = node.get_parent()

func open_duck_window():
	if duck_window: return  # Bereits offen
	duck_window = load(WINDOW_SCENE_PATH).instantiate()
	duck_window.set_duck(current_duck)
	duck_window.closed.connect(func():
		
		
		close_duck_window()
		
	)

	canvas.add_child(duck_window)

func close_duck_window():
	if duck_window:
		duck_camera.toggle_camera_off()
		duck_window.queue_free()
		duck_window = null


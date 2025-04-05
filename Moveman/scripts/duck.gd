extends CharacterBody2D

@export var fsm: Node  # Assign FSM node in the editor
#@export var pond: Node  # Assign in the editor when spawning
var known_locations: Array[Node] = []

@onready var hover_area = $HoverArea2D
@onready var info_box = $Infobox

@export var camera_button: Button

var is_hovered = false
signal update_data
var lock_ui = false

var data_manager

func _ready():
	data_manager = get_tree().get_root().get_node("Main/DataManager")
	hover_area.shape_size = Vector2(70, 70)
	hover_area.connect("hovered", _on_hover)
	hover_area.connect("unhovered", _on_unhover)
	hover_area.connect("clicked", _on_click)
	changed_Info()
	
	data_manager.change_max_on_resource("food", 20)

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


extends CanvasLayer

var data_manager
var civ_manager
var civ_polling := true

@onready var locations_list = get_node("/root/Main/CanvasLayer/HUD/VBoxContainer/MarginContainer2/Panel2/LocationsLabel")
@onready var resource_food = get_node("/root/Main/CanvasLayer/HUD/VBoxContainer/MarginContainer/Panel/MarginContainer/HBoxContainer/SlotFood")  # Update this based on your actual HUD elements
@onready var civ_duck = get_node("/root/Main/CanvasLayer/HUD/VBoxContainer/MarginContainer/Panel/MarginContainer/HBoxContainer/SlotCiv")  # Update this based on your actual HUD elements

func _ready():
	
	await get_tree().process_frame 
	data_manager = get_tree().get_root().get_node("Main/DataManager")
	
	if data_manager:
		data_manager.resource_updated.connect(_on_resource_updated)
		data_manager.locations_updated.connect(_on_update_locations_display)
		
func _process(_delta):
	if civ_polling:
		var maybe_civ = get_node_or_null("/root/Main/GameContainer/Duckland/CharacterManager")
		if maybe_civ:
			civ_manager = maybe_civ
			civ_manager.civ_updated.connect(_on_civ_updated_display)
			print("Connected to civ_manager")
			civ_polling = false  # stop checking
			

func _on_update_locations_display(locations):
	var text = "Known Locations:\n"
	for loc in locations:
		text += "- Pos at: %s\n" % str(loc.position)
	locations_list.text = text


func _on_resource_updated(resource_name, resource):
	if resource_name == "food":
		resource_food.display_slot_update(resource_name, resource)

func _on_civ_updated_display(type, civ_data):
	if type == "duck":
		civ_duck.display_slot_update(type, civ_data)

extends CanvasLayer

var data_manager

@onready var locations_list = get_node("/root/Main/HudCanvas/Panel/VBoxContainer/LocationsLabel")
@onready var resource_food = get_node("/root/Main/HudCanvas/Panel/VBoxContainer/HBoxContainer/SlotFood")  # Update this based on your actual HUD elements

func _ready():
	await get_tree().process_frame 
	data_manager = get_tree().get_root().get_node("Main/DataManager")
	
	print("DataManager reference:", data_manager)  # Debugging
	
	if data_manager:
		data_manager.resource_updated.connect(_on_resource_updated)
		data_manager.locations_updated.connect(_on_update_locations_display)

func _on_update_locations_display(locations):
	var text = "Known Locations:\n"
	for loc in locations:
		text += "- Pos at: %s\n" % str(loc.position)
	locations_list.text = text


func _on_resource_updated(resource_name, resource):
	if resource_name == "food":
		resource_food.resource_update(resource_name, resource)

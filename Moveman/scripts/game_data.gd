extends Node

var hud_locations: Array[Node] = []

# Add an item to the list
func add_item(item):
	hud_locations.append(item)

# Remove an item from the list
func remove_item(item):
	hud_locations.erase(item)

# Get the entire list
func get_list() -> Array:
	return hud_locations
	
	
var global_modifiers = {
	"gathering": 1.0,
	"crafting": 1.0
}

func get_global_modifier(name: String) -> float:
	return global_modifiers.get(name, 1.0)

func set_global_modifier(name: String, value: float):
	global_modifiers[name] = value

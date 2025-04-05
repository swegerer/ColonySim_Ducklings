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

extends Node2D

var discovered_locations: Array[Node] = []

func register_location(location):
	if location not in discovered_locations:
		discovered_locations.append(location)
	if location not in GameData.get_list():
		GameData.add_item(location)

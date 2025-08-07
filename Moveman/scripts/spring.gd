extends Node2D

var discovered_locations: Array[Node] = []
var inventory := Inventory.new()

var data_manager

func _ready():
	await get_tree().process_frame 
	data_manager = get_tree().get_root().get_node("Main/DataManager")
	
	print("DataManager reference:", data_manager)  # Debugging
	


func register_location(location):
	### Vielleicht uneffizient. Muss ich vielleicht schon hier prüfen obs
	### notwendig ist bevor ich signal aussende 
	data_manager.new_location(location)


func get_hypertext() -> String:
	return "[b]%s[/b] at (%.0f, %.0f)\n" % [name, position.x, position.y]
	

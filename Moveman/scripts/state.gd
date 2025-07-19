extends Node

var state_machine: Node = null
@export var character: CharacterBody2D

@export var speed: float = 100.0

var takes_work: bool = true
var location_node


func enter():
	if character and character.has_node("SensesArea2D"):
		var senses = character.get_node("SensesArea2D")
		if senses.is_connected("area_entered", Callable(self, "_on_Area2D_area_entered")):
			senses.disconnect("area_entered", Callable(self, "_on_Area2D_area_entered"))
		senses.connect("area_entered", Callable(self, "_on_Area2D_area_entered"))

	

func exit():
	if character and character.has_node("SensesArea2D"):
		var senses = character.get_node("SensesArea2D")
		if senses.is_connected("area_entered", Callable(self, "_on_Area2D_area_entered")):
			senses.disconnect("area_entered", Callable(self, "_on_Area2D_area_entered"))
	
	#if character and character.has_node("SensesArea2D"):
	#	character.get_node("SensesArea2D").area_entered.disconnect(_on_Area2D_area_entered)

func _on_Area2D_area_entered(area):
	location_node = area.get_parent()
	
	if area.is_in_group("food") and takes_work:
		print("ChangeState: " + character.name +  "on place: ")
		state_machine.change_state("WorkState", area.get_parent(), character)
	elif area.is_in_group("food") and location_node not in character.known_locations:
		character.known_locations.append(location_node)
		state_machine.change_state("HomewardsState")
	elif area.is_in_group("food") and takes_work:
		state_machine.change_state("WorkState")
	elif area.is_in_group("base"): 
		if location_node not in character.known_locations:
			character.known_locations.append(location_node)
		
		character.exchange_locations(location_node)  # Always sync locations if it's a base
		character.unload_to_base(location_node)
		

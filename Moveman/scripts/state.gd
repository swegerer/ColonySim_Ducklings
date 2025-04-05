extends Node

var state_machine: Node = null
@export var character: CharacterBody2D

@export var sprite_Duckbody: Sprite2D
@export var sprite_Frontwheel: Sprite2D
@export var sprite_Backwheel: Sprite2D

@export var speed: float = 100.0

func update(delta):
	if state_machine.character.velocity.x > 0:
		sprite_Duckbody.flip_h = true
	elif state_machine.character.velocity.x < 0:
		sprite_Duckbody.flip_h = false
	# Update wheel rotations
	sprite_Frontwheel.rotation += state_machine.character.velocity.length() * 0.1
	sprite_Backwheel.rotation += state_machine.character.velocity.length() * 0.1
	
func enter():
	if character and character.has_node("SensesArea2D"):
		character.get_node("SensesArea2D").area_entered.connect(_on_Area2D_area_entered)


func exit():
	if character and character.has_node("SensesArea2D"):
		character.get_node("SensesArea2D").area_entered.disconnect(_on_Area2D_area_entered)

func _on_Area2D_area_entered(area):
	var location_node = area.get_parent()
	if area.is_in_group("food") and location_node not in character.known_locations:
		character.known_locations.append(location_node)
		state_machine.change_state("HomewardsState")
	elif area.is_in_group("base"): 
		print("-----------------------------")
		if location_node not in character.known_locations:
			character.known_locations.append(location_node)
		character.exchange_locations(location_node)  # Always sync locations if it's a base
		

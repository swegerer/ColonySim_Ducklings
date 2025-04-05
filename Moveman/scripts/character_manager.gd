extends Node

var characters = []  # Stores references to all spawned characters

func add_character(parent: Node, character_scene: PackedScene):
	var character = character_scene.instantiate()
	
	# Example: Assign a random name
	character.name = "Character_" + str(characters.size() + 1)
	# Add to game tracking lists
	characters.append(character)
	# Add to scene
	parent.add_child(character)
	
	return character  # Return the new character in case anything needs modifying

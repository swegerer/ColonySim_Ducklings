extends Node


signal civ_updated(type, civ_data)

var civ_groups: Dictionary = {
	"duck": CivData.new(10, 3),
	"builder": CivData.new(5, 1),
}

var civ_containers: Dictionary = {
	"duck": [],
	"builder": [],
}

func get_civ_summaries():
	return civ_groups  # Just returns dictionary of CivData

func get_civ_count(civ_name):
	print("")
	
func add_character(parent: Node, type: String, character_scene):
	if not civ_groups.has(type): return
	
	#var character = character_scene.instantiate()
	var character = character_scene
	character.name = "Character_" + str(civ_containers[type].size() + 1)
	
	character.reparent(parent)
	#parent.add_child(character)
	

	
	var sense_shape = character.get_node("SensesArea2D/CollisionSenses") as CollisionShape2D
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = 450
	sense_shape.shape = circle_shape

	# Kollisionsbereich setzen
	var body_shape = character.get_node("CollisionMovement") as CollisionShape2D
	var rect_shape = RectangleShape2D.new()
	rect_shape.size = Vector2(25, 35)
	body_shape.shape = rect_shape

	civ_containers[type].append(character)
	civ_groups[type].set_value(civ_containers[type].size())
	civ_updated.emit(type, civ_groups[type])
	
	return character

extends Node

@export var character: CharacterBody2D  # Reference to the character
var current_state = null  # Active state script

@onready var audio_manager = get_node("/root/Main/AudioManager")  # Adjust path


func _ready():
	# Assign the state machine reference to all child states
	for child in get_children():
		if child is Node and not child is AudioStreamPlayer2D:
			child.state_machine = self  # Set reference
			
	if get_child_count() > 0:
		current_state = get_child(0)  # Start with the first state
		current_state.enter()

func change_state(new_state_name: String, location_node_arg: Node = null, character_arg: CharacterBody2D = null):
	print("New State: " + str(new_state_name))
	play_quack()
	
	if current_state:
		current_state.exit()
		
	var new_state = get_node_or_null(new_state_name)
	current_state = new_state
		
	if character_arg != null:
		current_state.character = character_arg

	if location_node_arg != null:
		current_state.location_node = location_node_arg
	
	current_state.enter()

func _process(delta):
	if current_state:
		current_state.update(delta)
		
func play_quack():
	audio_manager.play_quack(self.global_position)


func get_state():
	return current_state.name

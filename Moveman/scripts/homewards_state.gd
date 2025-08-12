extends "res://scripts/state.gd"

@export var wander_speed := 100
@export var wander_time := 3.0

var timer = 0
var direction = Vector2.ZERO

func enter():
	super()
	print("Entering Homewards State")
	go_Home()
	
func exit():
	super()
	print("Exit Homewards State")

func update(delta):
	state_machine.character.velocity = direction * speed
	state_machine.character.move_and_slide()
	
func go_Home():
	direction = (character.known_locations[0].global_position - character.global_position).normalized()
	print("test")


func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("base"):
		#character.unload_to_base(area.get_parent())
		#if character.has_item():
		
		# TODO: only if unload is necessary
		state_machine.change_state("UnloadState", area.get_parent(), character)

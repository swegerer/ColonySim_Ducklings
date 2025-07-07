extends "res://scripts/State.gd"

var direction_timer = 0
var timer = 0
var direction = Vector2.ZERO


func enter():
	super()
	location_node.ask_entry(character)
	
	
func update(delta):
	
	timer += delta
	
	state_machine.character.velocity = Vector2(0, 0)
	state_machine.character.move_and_slide()
	

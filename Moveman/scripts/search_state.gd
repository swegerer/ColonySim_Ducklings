extends "res://scripts/State.gd"

@export var wander_speed := 100
@export var wander_time := 25.0
var direction_intervall := 5

var direction_timer = 0
var timer = 0
var direction = Vector2.ZERO

func enter():
	super()
	print("Entering Search State")
	timer = 0
	direction_timer = 0
	direction_intervall = randf() * 10
	pick_random_direction()
	

func update(delta):
	super(delta)
	
	timer += delta
	direction_timer += delta
	
	if timer >= wander_time:
		state_machine.change_state("IdleState")  # Return to idle after time
		
	if direction_timer >= direction_intervall:
		direction_intervall = (randf() * 10) + 3
		direction_timer = 0
		pick_random_direction()
		
	state_machine.character.velocity = direction * speed
	state_machine.character.move_and_slide()
	
	# Flip sprite
	

func pick_random_direction():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()  # Pick a random direction


func on_collision():
	print("Collided! Picking new direction.")
	pick_random_direction()


extends Node



# Start time (you can change this at runtime)
var hours: int = 0
var minutes: int = 0

var timer_textures = {
	0: preload("res://sprites/timer_1.png"),
	1: preload("res://sprites/timer_2.png"),
	3: preload("res://sprites/timer_3.png"),
	4: preload("res://sprites/timer_4.png"),
	5: preload("res://sprites/timer_5.png"),
	6: preload("res://sprites/timer_6.png"),
	7: preload("res://sprites/timer_7.png"),
	# Add more as needed...
}


# How fast the in-game clock should run (1 = real time)
var time_scale: float = 1.0

# Timer for updating
var _accumulated_time: float = 60.0

func _process(delta: float) -> void:
	_accumulated_time += delta * time_scale
	if _accumulated_time >= 60.0:
		_accumulated_time -= 60.0
		_tick_clock()

func _tick_clock() -> void:
	minutes += 1
	if minutes >= 10:
		minutes = 0
		hours += 1
		if hours >= 4:
			hours = 0
	update_display()

func update_display():
	self.texture = timer_textures[hours]

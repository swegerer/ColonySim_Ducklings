extends MarginContainer

@export var stat_line: PackedScene
@export var VBox: VBoxContainer

var stat_line_health
var stat_line_damage
var stat_line_energy
var stat_line_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	stat_line_health = stat_line.instantiate() as StatLine
	stat_line_damage = stat_line.instantiate() as StatLine
	stat_line_energy = stat_line.instantiate() as StatLine
	stat_line_speed = stat_line.instantiate() as StatLine
	
	VBox.add_child(stat_line_health)
	VBox.add_child(stat_line_damage)
	VBox.add_child(stat_line_energy)
	VBox.add_child(stat_line_speed)
	
	stat_line_health.set_stat_name("Health")
	stat_line_damage.set_stat_name("Damage")
	stat_line_energy.set_stat_name("Energy")
	stat_line_speed.set_stat_name("Speed")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

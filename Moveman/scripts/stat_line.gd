class_name StatLine
extends MarginContainer

@export var stat_label: Label
@export var stat_edit: LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_stat_name(p_name):
	stat_label.text = p_name

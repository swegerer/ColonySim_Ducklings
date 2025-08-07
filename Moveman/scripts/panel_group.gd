extends VBoxContainer

@export var panel1: Panel
@export var panel2: Panel

func _process(_delta):
	var total_height := 0.0
	
	# Dynamisch Größe von Panel1 berechnen
	var panel1_min_size = get_required_panel_size(panel1)
	panel1.size = panel1_min_size
	panel1.position = Vector2(0, 0)
	
	# Abstand
	total_height = panel1.position.y + panel1.size.y + 10
	
	# Panel2 darunter positionieren
	var panel2_min_size = get_required_panel_size(panel2)
	panel2.size = panel2_min_size
	panel2.position = Vector2(0, total_height)

	# Optional: Gesamtgröße dieses Control-Nodes anpassen
	size.y = panel2.position.y + panel2.size.y

func get_required_panel_size(panel: Control) -> Vector2:
	var min_size = Vector2.ZERO
	for child in panel.get_children():
		if child is Control:
			var end = child.position + child.size
			min_size.x = max(min_size.x, end.x)
			min_size.y = max(min_size.y, end.y)
	return min_size

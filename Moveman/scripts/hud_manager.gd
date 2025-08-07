extends CanvasLayer

var data_manager
var civ_manager
var civ_polling := true

@onready var character_list = get_node("/root/Main/CanvasLayer/HUD/VBoxContainer/PanelGroup/MarginContainer3/Panel2/CharactersLabel")
@onready var locations_list = get_node("/root/Main/CanvasLayer/HUD/VBoxContainer/PanelGroup/MarginContainer2/Panel2/LocationsLabel")
@onready var resource_food = get_node("/root/Main/CanvasLayer/HUD/VBoxContainer/MarginContainer/Panel/MarginContainer/HBoxContainer/SlotFood")  # Update this based on your actual HUD elements
@onready var civ_duck = get_node("/root/Main/CanvasLayer/HUD/VBoxContainer/MarginContainer/Panel/MarginContainer/HBoxContainer/SlotCiv")  # Update this based on your actual HUD elements


func _ready():
	character_list.meta_underlined = false
	character_list.connect("meta_clicked", Callable(self, "_on_duck_clicked"))
	await get_tree().process_frame 
	data_manager = get_tree().get_root().get_node("Main/DataManager")
	
	if data_manager:
		data_manager.resource_updated.connect(_on_resource_updated)
		data_manager.locations_updated.connect(_on_update_locations_display)
		
func _process(_delta):
	if civ_polling:
		var maybe_civ = get_node_or_null("/root/Main/GameContainer/Duckland/CharacterManager")
		if maybe_civ:
			civ_manager = maybe_civ
			civ_manager.civ_updated.connect(_on_civ_updated_display)
			print("Connected to civ_manager")
			civ_polling = false  # stop checking
			

func _on_update_locations_display(locations):
	var text := "[font_size={35}][b][u]Ducks:[/u][/b][/font_size]\n"
	for loc in locations:
		text += loc.get_hypertext()
	locations_list.text = text


func _on_resource_updated(resource_name, resource):
	if resource_name == "food":
		resource_food.display_slot_update(resource_name, resource)

func _on_civ_updated_display(type, civ_data):
	if type == "duck":
		civ_duck.display_slot_update(type, civ_data)
	
	var text := "[font_size={35}][b][u]Ducks:[/u][/b][/font_size]\n"
	for duck in Globals.ducks:
		var id = duck.get_meta("id")
		text += "[font_size={20}][url=%s]%s[/url][/font_size]" % [id, duck.get_hypertext()]
		#text += "[meta=%s] [img={35}x{35}]res://sprites/camera_on.png[/img][/meta]\n" % [id]
		text += "[url=%s] [img={35}x{35}]res://sprites/camera_on.png[/img][/url]\n" % [id]
	character_list.bbcode_enabled = true
	character_list.clear()
	character_list.append_text(text)



func _on_duck_clicked(meta):
	var duck = Globals.find_duck_by_id(meta)
	if duck:
		# Beispiel: Kamera auf Duck fokussieren
		print("Duck '%s' wurde geklickt" % duck.name)
		
		#Globals.camera_duck.follow(duck)
		duck.focus_camera_on(duck)
	else:
		print("Kein Duck mit ID '%s' gefunden" % meta)

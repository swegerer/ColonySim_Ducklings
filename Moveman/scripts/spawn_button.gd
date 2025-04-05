extends Button

@onready var gamescript = get_node("/root/Main/GameContainer/Duckland")
#@onready var gamescript = get_node("/root/Duckland")

# This function will be called when the button is pressed
func _ready():
	self.pressed.connect(_on_button_pressed)

# Function to handle the button press
func _on_button_pressed():
	gamescript.add_character()
	

extends Panel

# Optional: for debugging
@onready var icon_texture_rect: TextureRect = get_node("MarginContainer/icon")
@onready var name_text: RichTextLabel = get_node("MarginContainer2/richtext")


func set_item_data(item_data: ItemData) -> void:
	icon_texture_rect = get_node("MarginContainer/icon")
	name_text = get_node("MarginContainer2/richtext")

	if item_data.icon:
		var icon_texture = ImageTexture.create_from_image(item_data.icon)
		icon_texture_rect.texture = icon_texture

	name_text.clear()
	name_text.append_text("[b]%s[/b] x%d" % [item_data.name, item_data.amount])

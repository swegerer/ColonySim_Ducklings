extends TileMap


var time_since_last_fog_check = 0

func _process(delta):
	time_since_last_fog_check += delta
	if time_since_last_fog_check > 10:
		creep_light_fog()
		time_since_last_fog_check = 0


const NEIGHBOR_OFFSETS = [
	Vector2i.LEFT,
	Vector2i.RIGHT,
	Vector2i.UP,
	Vector2i.DOWN,
	Vector2i(-1, -1),
	Vector2i(1, -1),
	Vector2i(-1, 1),
	Vector2i(1, 1),
]

func creep_light_fog():
	var to_fog := {}  # Use a dictionary as a set for unique positions
	var used_rect := get_used_rect()

	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			var pos = Vector2i(x, y)

			# Only consider already fogged tiles
			if get_cell_tile_data(0, pos):
				# Check four directions
				for offset in [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]:
					var neighbor = pos + offset

					if is_tile_in_bounds(neighbor, used_rect):
						# If neighbor is clear (no fog tile), mark it for fogging
						if not get_cell_tile_data(0, neighbor):
							to_fog[neighbor] = true

	# Apply fog to all newly discovered edge tiles
	for pos in to_fog.keys():
		set_cell(0, pos, 0, Vector2i(12, 5), 0)  # Use correct fog tile source & coords

func is_tile_in_bounds(pos: Vector2i, bounds: Rect2i) -> bool:
	return bounds.has_point(pos)


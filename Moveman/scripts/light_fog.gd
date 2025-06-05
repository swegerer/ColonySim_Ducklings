extends TileMap

@onready var rng = RandomNumberGenerator.new()
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
		set_cell(0, pos, 0, Vector2i(1, 1), 0)  # Use correct fog tile source & coords

func is_tile_in_bounds(pos: Vector2i, bounds: Rect2i) -> bool:
	return bounds.has_point(pos)
	

func creep_light_fog_gradually():
	var to_fog := []  # or use a Set, then convert to array
	var used_rect := get_used_rect()

	# Step 1: Gather fog targets
	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			var pos = Vector2i(x, y)

			if get_cell_tile_data(0, pos):
				for offset in [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]:
					var neighbor = pos + offset
					if is_tile_in_bounds(neighbor, used_rect) and not get_cell_tile_data(0, neighbor):
						to_fog.append(neighbor)

	# Step 2: Random fog creep over time
	while to_fog.size() > 0:
		var index = rng.randi_range(0, to_fog.size() - 1)
		var pos = to_fog[index]
		to_fog.remove_at(index)

		set_cell(0, pos, 0, Vector2i(1, 1), 0)  # Replace with your fog tile

		# Wait a random amount between 1 and 2 seconds
		var delay = rng.randf_range(0.1, 1.0)
		await get_tree().create_timer(delay).timeout




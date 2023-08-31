extends Node

# Private
var _tiles: Dictionary = {}

func _spawn_entity(entity_id: String, at_position: Vector2 = Vector2.ZERO) -> Entity:
	if !is_in_bounds(at_position):
		return
	
	var entity: Entity = Entity.new(entity_id, at_position)
	Global.add_entity.emit(entity)
	return entity

func _spawn_tile(tile_id: String, at_position: Vector2 = Vector2.ZERO) -> Tile:
	var tile: Tile = Tile.new(tile_id, at_position)
	Global.add_tile.emit(tile)
	return tile

func _generate_tiles() -> void:
	for y in range(size.y):
		for x in range(size.x):
			if x == 0 or y == 0 or x == size.x - 1 or y == size.y - 1:
				_tiles[Vector2(x,y)] = _spawn_tile("Tree", Vector2(x,y))
			else:
				_tiles[Vector2(x,y)] = _spawn_tile("Floor", Vector2(x, y))

# Public
var size: Vector2

func generate_level() -> void:
	_generate_tiles()

func is_in_bounds(position: Vector2) -> bool:
	if _tiles.has(position):
		return true
	
	return false

func is_solid(position: Vector2) -> bool:
	return _tiles[position].is_solid if is_in_bounds(position) else false

func get_tile(position: Vector2) -> Tile:
	return _tiles[position] if is_in_bounds(position) else null

func get_passable_tiles() -> Array[Tile]:
	var tiles: Array[Tile] = []
	for tile in _tiles:
		if !_tiles[tile].is_solid:
			tiles.push_back(_tiles[tile])
	
	return tiles

func get_random_passable_tile() -> Tile:
	var tiles: Array[Tile] = get_passable_tiles()
	tiles.shuffle()
	return tiles[0]
	

class_name Tile extends Node

# Private
var _data: TileDefinition
var _sprite: Sprite2D
var _container: Array[Item] = []

func _set_position(new_position: Vector2) -> void:
	_sprite.position = new_position * Config.cell_size
	position = new_position

func _get_position() -> Vector2:
	return position

func _update_data() -> void:
	name = _data.type
	_sprite.frame = _data.frame_index
	_sprite.self_modulate = _data.tint

# Public
var position: Vector2 = Vector2.ZERO:
	set = _set_position,
	get = _get_position

var id: String
var is_solid: bool
var is_opaque: bool
var is_container: bool
var has_items: bool:
	get:
		return _container.size()
var has_entity: bool:
	get:
		return entity != null

var entity: Entity

func _init(tile_id: String, at_position: Vector2 = Vector2.ZERO) -> void:
	# Store data
	_data = Config.tile_definitions[tile_id]
	name = _data.id
	id = _data.id
	
	# Set flags
	is_solid = _data.is_solid
	is_opaque = _data.is_opaque
	is_container = _data.is_container
	has_items = false
	has_entity = false
	
	# Create sprite
	_sprite = Sprite2D.new()
	_sprite.name = "Sprite"
	_sprite.texture = Config.tileset.texture
	_sprite.hframes = Config.tileset.hframes
	_sprite.vframes = Config.tileset.vframes
	_sprite.frame = _data.frame_index
	_sprite.self_modulate = _data.tint
	_sprite.z_index = _data.layer
	add_child(_sprite, true)
	
	position = at_position

func set_data(entity_data: String) -> void:
	_data = Config.entity_definitions[entity_data]
	_update_data()

func set_property(property: String, value) -> void:
	if property in _data:
		_data[property] = value
	
	_update_data()

func insert(item_id: String) -> void:
	if !is_container:
		return
	
	var item: Item = contains(item_id)
	if item:
		item.amount += 1
	else:
		var new_item: Item = Config.item_definitions[item_id].new()
		new_item.name = item_id
		_container.push_back(new_item)
		add_child(new_item, true)

func remove(item_id: String, amount: int = 1) -> void:
	if !is_container:
		return
	var item: Item = contains(item_id)
	if item:
		if item.amount == 1:
			_container.erase(item)
			item.queue_free()
		elif item.amount > 1:
			item.amount -= amount

func contains(item_id: String) -> Item:
	for item in _container:
		if item.name == item_id:
			return item
	return null

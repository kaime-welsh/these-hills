class_name Entity extends Node

signal health_changed(health: int)
signal died(amount: int)

# Private
var _data: EntityDefinition
var _sprite: Sprite2D
var _components: Dictionary = {}
var _active: bool = true

var _equiped_items: Dictionary = {
	"head": null,
	"body": null,
	"l. hand": null,
	"r. hand": null,
	"legs": null,
	"feet": null,
}

func _set_position(new_position: Vector2) -> void:
	if !is_inside_tree():
		await ready
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(
		_sprite,
		"position",
		new_position * Config.cell_size,
		0.075
	)
	position = new_position

func _get_position() -> Vector2:
	return position

func _update_sprite() -> void:
	_sprite.frame = frame_index
	_sprite.self_modulate = tint
	_sprite.z_index = layer

func _update_data() -> void:
	name = _data.entity_id
	id = _data.entity_id
	frame_index = _data.frame_index
	tint = _data.tint
	layer = _data.layer
	
	max_health = 10 + constitution
	
	bump_action = Config.actions[_data.bump_action_type].new()
	bump_action.bind(self)
	
	for item in _data.component_list.keys():
		add_component(item, _data.component_list[item])

# Public
var id: String
var position: Vector2 = Vector2.ZERO:
	set = _set_position,
	get = _get_position
var frame_index: int
var tint: Color
var layer: int
var bump_action: Action = null

var health: int:
	set(value):
		health = value
		health_changed.emit(health)
var max_health: int

var defense: int = 0
var strength: int = 0
var dexterity: int = 0
var constitution: int = 0

var inventory: Array[Item] = []

func _init(entity_id: String, at_position: Vector2 = Vector2.ZERO) -> void:
	_data = Config.entity_definitions[entity_id]
	
	strength = _data.strength
	dexterity = _data.dexterity
	constitution = _data.constitution
	
	_update_data()
	health = max_health
	
	# Create player sprite
	_sprite = Sprite2D.new()
	_sprite.name = "Sprite"
	_sprite.texture = Config.tileset.texture
	_sprite.hframes = Config.tileset.hframes
	_sprite.vframes = Config.tileset.vframes
	_sprite.frame = frame_index
	_sprite.self_modulate = tint
	_sprite.z_index = layer
	add_child(_sprite, true)
	
	move(at_position)

func set_data(entity_data: String) -> void:
	_data = Config.entity_definitions[entity_data]
	_update_data()

func set_property(property: String, value) -> void:
	if property in _data:
		_data[property] = value

func add_component(new_component_name: String, parameters: Dictionary = {}) -> void:
	var component: Component = Config.components[new_component_name].new(self, parameters)
	component.name = new_component_name
	add_child(component, true)
	_components[component.name] = component

func remove_component(component_name: String) -> void:
	get_component(component_name).queue_free()
	_components.erase(component_name)

func get_component(component_name: String) -> Component:
	return _components[component_name]

func set_component(component_name: String, property: String, value) -> void:
	var component: Component = get_component(component_name)
	
	if property in component:
		component.set(property, value)

func clear_components() -> void:
	for component in _components:
		_components[component].queue_free()
	
	_components.clear()

func get_equiped_item_name(slot: String) -> String:
	if _equiped_items[slot] == null:
		return "EMPTY"
	
	if _equiped_items[slot].amount > 1:
		return "%s x%s" % [_equiped_items[slot].id, _equiped_items[slot].amount]
	else:
		return _equiped_items[slot].id

func get_equiped_item(slot: String) -> Item:
	return _equiped_items[slot]

func add_item(item: Item) -> void:
	if !inventory.has(item):
		item.amount += 1
		inventory.push_back(item)
	else:
		inventory[item].amount += 1

func get_item_index(item: Item) -> void:
	return inventory.find(item)

func equip_from_inventory(item_index: int, slot: String) -> void:
	if !inventory[item_index].can_equip:
		return
	
	if slot == "hands":
		if _equiped_items["l. hand"] == null:
			_equiped_items["l. hand"] = inventory[item_index].equip(self)
		elif _equiped_items["l. hand"] != null:
			add_item(_equiped_items["l. hand"])
			_equiped_items["l. hand"] = inventory[item_index].equip(self)
		
		elif _equiped_items["r. hand"] == null:
			_equiped_items["r. hand"] = inventory[item_index].equip(self)
		elif _equiped_items["r. hand"] != null:
			add_item(_equiped_items["r. hand"])
			_equiped_items["r. hand"] = inventory[item_index].equip(self)
	
	elif _equiped_items[slot] == null: 
		_equiped_items[slot] = inventory[item_index].equip(self)
	else:
		add_item(_equiped_items[slot])
		_equiped_items[slot] = inventory[item_index].equip(self)
	
	inventory[item_index].amount -= 1
	if inventory[item_index].amount <= 0:
		inventory.remove_at(item_index)

func unequip_item(slot: String) -> void:
	add_item(_equiped_items[slot])
	_equiped_items[slot].unequip(self)
	_equiped_items[slot] = null

func try_move(direction: Vector2) -> void:	
	if !Map.is_in_bounds(position + direction):
		return
		
	if Map.is_solid(position + direction):
		return
	
	if Map.get_tile(position + direction).has_entity:
		var entity: Entity = Map.get_tile(position + direction).entity
		if entity._active:
			entity.bump(self)
			return

	move(position + direction)

func move(new_position: Vector2) -> void:
	Map.get_tile(new_position).entity = self
	Map.get_tile(position).entity = null
	position = new_position

func hide() -> void:
	_sprite.visible = false
	_active = false

func show() -> void:
	_sprite.visible = true
	_active = true

func hurt(amount: int) -> void:
	health -= amount

	if health <= 0:
		_active = false
		die()

	else:
		var tween: Tween = get_tree().create_tween()
		_sprite.self_modulate = Color.RED
		tween.tween_property(_sprite, "self_modulate", tint, 0.35)

func heal(amount: int) -> void:
	if health < max_health:
		Global.event_message.emit("The [color=%s]%s[/color] [color=green]heals %s hp.[/color]" % [
			_data.tint.to_html(),
			id,
			amount
		])
		
		var tween: Tween = get_tree().create_tween()
		_sprite.self_modulate = Color.MEDIUM_SPRING_GREEN
		tween.tween_property(_sprite, "self_modulate", tint, 0.35)
		
		health += amount

func die() -> void:
	Global.event_message.emit("The [color=%s]%s[/color] [color=red]dies![/color]" % [
		_data.tint.to_html(),
		id
	])
	
	id += " corpse"
	frame_index = 566
	tint = Color.RED
	layer = 0
	_update_sprite()
	clear_components()
	Map.get_tile(position).entity = null
	died.emit()

func tick() -> void:
	if !_active:
		return
	
	for component in _components:
		_components[component].tick()

func bump(other: Entity) -> void:
	bump_action.perform(other)

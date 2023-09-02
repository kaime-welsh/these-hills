class_name Item extends Node

# Private

# Public
var id: String = "[Empty]"
var description: String = ""
var icon: Texture2D
var amount: int = 0

var can_equip: bool = false
var slot: String = ""

var is_weapon: bool = false
var damage: int = 0

var is_armor: bool = false
var defense: int = 0

func _init(item_id: String) -> void:
	var item_definition = Config.item_definitions[item_id] as ItemDefinition
	id = item_definition.id
	description = item_definition.description
	icon = item_definition.icon
	
	can_equip = item_definition.can_equip
	slot = item_definition.slot
	
	is_weapon = item_definition.is_weapon
	damage = item_definition.damage
	
	is_armor = item_definition.is_armor
	defense = item_definition.defense

func equip(entity: Entity) -> Item:
	if is_weapon:
		entity.strength += damage
	
	if is_armor:
		entity.defense += defense
	
	return self

func unequip(entity: Entity) -> Item:
	if is_weapon:
		entity.strength -= damage
	
	if is_armor:
		entity.defense -= defense
	
	return self

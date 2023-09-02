class_name EntityDefinition extends Resource

@export_group("Visuals")
@export var entity_id: String = "EMPTY"
@export var frame_index: int = 0
@export_color_no_alpha var tint: Color = Color.WHITE
@export_enum('Tile:-1', 'Corpse:0', 'Item:1', 'Entity:2', 'Player:3') var layer: int = 2

@export_group("Stats")
@export var strength: int = 1
@export var dexterity: int = 1
@export var constitution: int = 1

@export_group("Data")
@export var bump_action_type: String
@export var component_list: Dictionary = {}

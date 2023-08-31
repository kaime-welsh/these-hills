class_name EntityDefinition extends Resource

@export var entity_id: String = "EMPTY"
@export var health: int = 1
@export var frame_index: int = 0
@export_color_no_alpha var tint: Color = Color.WHITE
@export_enum('Tile:-1', 'Corpse:0', 'Item:1', 'Entity:2', 'Player:3') var layer: int = 2
@export var bump_action_type: String
@export var component_list: Dictionary = {}

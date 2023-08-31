class_name TileDefinition extends Resource

@export var id: String
@export var frame_index: int = 0
@export_color_no_alpha var tint: Color = Color.WHITE
@export_enum('Tile:-1', 'Corpse:0', 'Item:1', 'Entity:2', 'Player:3') var layer: int = -1

@export_group("Flags")
@export var is_solid: bool = false
@export var is_opaque: bool = false
@export var is_container: bool = false

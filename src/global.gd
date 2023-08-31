extends Node

signal spawn_entity(entity_id: String, at_position: Vector2)
signal add_entity(entity: Entity)
signal spawn_tile(tile_id: String, at_position: Vector2)
signal add_tile(tile: Tile)

signal event_message(message: String)
signal next_turn()

var map: Map
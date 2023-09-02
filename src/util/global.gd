extends Node

signal world_ready()
signal spawn_entity(entity_id: String, at_position: Vector2)
signal add_entity(entity: Entity)
signal spawn_tile(tile_id: String, at_position: Vector2)
signal add_tile(tile: Tile)
signal next_turn()
signal tick()

signal toggle_inventory()
signal populate_ui()
signal event_message(message: String)

var player: Entity
var paused: bool = false

extends Node

var cell_size: int = 16
var tileset: Dictionary = {
	texture = preload("res://data/images/monochrome_packed.png"),
	hframes = 49,
	vframes = 22,
}

var entity_definitions: Dictionary = {
	"Player": preload("res://data/entities/player.tres"),
	"Test": preload("res://data/entities/test.tres"),
}

var tile_definitions: Dictionary = {
	"Empty": preload("res://data/tiles/empty.tres"),
	"Floor": preload("res://data/tiles/floor.tres"),
	"Wall": preload("res://data/tiles/wall.tres"),
	"Tree": preload("res://data/tiles/tree.tres"),
}

var item_definitions: Dictionary = {
	
}

var actions: Dictionary = {
	"Attack": preload("res://src/actions/attack.gd")
}

var components: Dictionary = {
	"PlayerInput": preload("res://src/components/player_input.gd"),
	"RandomMover": preload("res://src/components/random_mover.gd"),
}

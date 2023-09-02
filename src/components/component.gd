class_name Component extends Node

#Private

# Public
var entity: Entity
var settings: Dictionary

func _init(parent_entity: Entity, parameters: Dictionary) -> void:
	entity = parent_entity
	settings = parameters

func tick() -> void:
	pass

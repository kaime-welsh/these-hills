class_name Action extends Node

# Private

# Public
var entity: Entity

func bind(owning_entity: Entity) -> void:
	entity = owning_entity

func perform(_other: Entity) -> void:
	pass

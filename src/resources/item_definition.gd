class_name ItemDefinition extends Resource

@export var id: String = "Empty"
@export var description: String = ""
@export var icon: Texture2D

@export var can_equip:bool = false
@export_enum("head", "body", "hands", "legs", "feet") var slot: String

@export_group("Weapon")
@export var is_weapon: bool = false
@export var damage: int = 0

@export_group("Armor")
@export var is_armor: bool = false
@export var defense: int = 0

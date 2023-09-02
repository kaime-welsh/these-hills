extends Node

@onready var main_camera: Camera2D = $MainCamera
@onready var ui: CanvasLayer = $UI
@onready var side_panel: VBoxContainer = $UI/Control/HSplitContainer/SidePanel
@onready var backpack: Control = $UI/Control/HSplitContainer/MarginContainer/Backpack

@onready var tiles: Node = $World/Tiles
@onready var entities: Node = $World/Entities

var player: Entity

func _ready() -> void:
	Global.spawn_entity.connect(spawn_entity)
	Global.add_entity.connect(add_entity)
	Global.spawn_tile.connect(spawn_tile)
	Global.add_tile.connect(add_tile)
	Global.tick.connect(tick)
	
	setup_game()

func setup_game() -> void:
	Map.size = Vector2(16, 16)
	Map.generate_level()
	
	player = spawn_entity("Player", Map.get_passable_tiles()[0].position)
	player.died.connect(player_died)
	
	player.add_item(Item.new("ShortSword"))
	
	Global.player = player
	
	main_camera.position = Rect2(0, 0, Map.size.x - 8, Map.size.y - 1).get_center() * Config.cell_size
	for i in range(4):
		spawn_entity("Test", Map.get_random_passable_tile().position)
	
	Global.world_ready.emit()

func spawn_entity(entity_id: String, at_position: Vector2 = Vector2.ZERO) -> Entity:
	var entity: Entity = Entity.new(entity_id, at_position)
	entities.add_child(entity, true)
	return entity

func add_entity(entity: Entity) -> void:
	entities.add_child(entity, true)

func spawn_tile(tile_id: String, at_position: Vector2 = Vector2.ZERO) -> Tile:
	var tile: Tile = Tile.new(tile_id, at_position)
	tiles.add_child(tile, true)
	return tile

func add_tile(tile: Tile) -> void:
	tiles.add_child(tile, true)

func tick() -> void:
	if Global.paused:
		return
	
	for entity in entities.get_children():
		if entity.id != "Player":
			entity.tick()
	
	Global.next_turn.emit()

func player_died() -> void:
	for entity in entities.get_children():
		entity.queue_free()
	
	for tile in tiles.get_children():
		tile.queue_free()
	
	setup_game()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		backpack.populate()
		backpack.visible = !backpack.visible
		Global.paused = !Global.paused

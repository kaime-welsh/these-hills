class_name BackpackScreen extends Control

@onready var tree: Tree = $Panel/HBoxContainer/Backpack/Tree

func populate() -> void:
	for item in tree.get_root().get_children():
		tree.get_root().remove_child(item)
	
	for item in Global.player.inventory:
		var tree_item = tree.create_item(tree.get_root())
		tree_item.set_icon(0, item.icon)
		tree_item.set_text(1, item.id)
		tree_item.set_text(2, item.description)
		tree_item.set_text(3, str(item.amount))

func _ready() -> void:
	Global.world_ready.connect(func():
		tree.create_item(tree.get_root())
		populate()
	)
	
	Global.populate_ui.connect(populate)

func _on_tree_item_activated() -> void:
	var id = tree.get_selected().get_index()
	var player_item: Item =  Global.player.inventory[id]
	
	Global.player.equip_from_inventory(id, player_item.slot)
	Global.populate_ui.emit()

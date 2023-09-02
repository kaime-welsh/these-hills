class_name Invetory extends Tree

func populate() -> void:
	for item in get_root().get_children():
		get_root().remove_child(item)
	
	set_field("head")
	set_field("l. hand")
	set_field("r. hand")
	set_field("legs")
	set_field("feet")

func set_field(slot: String) -> void:
	var item: Item = Global.player.get_equiped_item(slot)
	var tree_item = create_item(get_root())
	
	if item:
		tree_item.set_text(0, "%s" % slot.capitalize())
		tree_item.set_icon(2, item.icon)
		tree_item.set_text(1, item.id)
	else:
		tree_item.set_text(0, "%s" % slot.capitalize())
		tree_item.set_text(1, "Empty")

func _ready() -> void:
	Global.world_ready.connect(func():
		create_item(get_root())
		populate()
	)
	
	Global.populate_ui.connect(populate)

func _on_item_activated() -> void:
	var tree_item: TreeItem = get_selected()
	if tree_item.get_text(1) == "Empty":
		return
	Global.player.unequip_item(tree_item.get_text(0).to_lower())
	Global.populate_ui.emit()

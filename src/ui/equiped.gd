class_name Equiped extends RichTextLabel

func populate() -> void:
	clear()
	
	push_bgcolor(Color.WHITE)
	push_color(Color.BLACK)
	append_text("EQUIPED")
	pop()
	pop()
	append_text("\nHead: %s\nL. Hand: %s\nR. Hand: %s\nFeet: %s" % [
		 Global.player.get_equiped_item_name("head"),
		 Global.player.get_equiped_item_name("left_hand"),
		 Global.player.get_equiped_item_name("right_hand"),
		 Global.player.get_equiped_item_name("feet"),
	])

func _ready() -> void:
	Global.world_ready.connect(populate)
	Global.next_turn.connect(populate)
	Global.populate_ui.connect(populate)

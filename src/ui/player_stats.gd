class_name PlayerStats extends RichTextLabel

func populate() -> void:
	clear()
	
	push_table(5)
	
	# HP cell
	push_cell()
	push_bgcolor(Color.RED)
	push_color(Color.BLACK)
	append_text("HP %s  " % Global.player.health)
	pop() # close color
	pop() # close bg_color
	pop() # close cell
	
	# DEF Cell
	push_cell()
	push_bgcolor(Color.BLUE)
	push_color(Color.BLACK)
	append_text("DEF %s  " % Global.player.defense)
	pop() # close color
	pop() # close bg_color
	pop() # close cell
	
	# STR Cell
	push_cell()
	push_bgcolor(Color.ORANGE_RED)
	push_color(Color.BLACK)
	append_text("STR %s  " % Global.player.strength)
	pop() # close color
	pop() # close bg_color
	pop() # close cell
	
	# DEX Cell
	push_cell()
	push_bgcolor(Color.YELLOW)
	push_color(Color.BLACK)
	append_text("DEX %s  " % Global.player.dexterity)
	pop() # close color
	pop() # close bg_color
	pop() # close cell
	
	# CON Cell
	push_cell()
	push_bgcolor(Color.GREEN)
	push_color(Color.BLACK)
	append_text("CON %s  " % Global.player.constitution)
	pop() # close color
	pop() # close bg_color
	pop() # close cell

func _ready() -> void:
	Global.world_ready.connect(populate)
	Global.next_turn.connect(populate)
	Global.populate_ui.connect(populate)


func _on_inventory_item_activated() -> void:
	pass # Replace with function body.

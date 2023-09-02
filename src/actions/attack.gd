class_name Attack extends Action

func perform(other: Entity) -> void:
	if other.id == entity.id:
		return
	
	Global.event_message.emit("[color=%s]%s[/color] [color=red]attacks the[/color] [color=%s]%s[/color] for %s damage!" % [
		other._data.tint.to_html(),
		other.id,
		entity._data.tint.to_html(),
		entity.id,
		1 + other.strength
	])
	
	entity.hurt(1 + other.strength)

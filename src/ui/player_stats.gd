class_name PlayerStats extends RichTextLabel

var player: Entity

func _ready() -> void:
	await Global.world_ready
	text = "[color=red]HP [/color]| %s" % Global.player.health
	
	Global.player.health_changed.connect(
		func(hp):
			text = "[color=red]HP [/color]| %s" % hp
	)

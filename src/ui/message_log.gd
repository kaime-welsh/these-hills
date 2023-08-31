class_name MessageLog extends RichTextLabel

func _ready() -> void:
	Global.event_message.connect(print_message)
	text += "[color=yellow]Welcome to the game.[/color]"

func print_message(message: String) -> void:
	text += "\n%s" % message

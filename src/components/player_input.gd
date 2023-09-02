class_name PlayerInput extends Component

var commands: Dictionary = {
	"move_left" = func(): entity.try_move(Vector2(-1, 0)),
	"move_right" = func(): entity.try_move(Vector2(1, 0)),
	"move_up" = func(): entity.try_move(Vector2(0, -1)),
	"move_up_left" = func(): entity.try_move(Vector2(-1, -1)),
	"move_up_right" = func(): entity.try_move(Vector2(1, -1)),
	"move_down" = func(): entity.try_move(Vector2(0, 1)),
	"move_down_left" = func(): entity.try_move(Vector2(-1, 1)),
	"move_down_right" = func(): entity.try_move(Vector2(1, 1)),
	"wait" = func(): entity.heal(1),
	"pick_up" = func(): entity.get_component("inventory").pick_up(),
}

func _init(parent_entity: Entity, parameters: Dictionary) -> void:
	super(parent_entity, parameters)

func _input(event: InputEvent) -> void:
	if Global.paused:
		return
	
	if !event is InputEventKey:
		return
	
	for command in commands:
		if event.is_action_pressed(command, true):
			commands[command].call()
			Global.tick.emit()

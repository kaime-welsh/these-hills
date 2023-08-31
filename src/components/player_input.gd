class_name PlayerInput extends Component

var commands: Dictionary = {
	"move_left" = func(): entity.try_move(Vector2(-1, 0)),
	"move_right" = func(): entity.try_move(Vector2(1, 0)),
	"move_up" = func(): entity.try_move(Vector2(0, -1)),
	"move_down" = func(): entity.try_move(Vector2(0, 1)),
}

func _init(parent_entity: Entity, parameters: Dictionary) -> void:
	super(parent_entity, parameters)

func _input(event: InputEvent) -> void:
	if !event is InputEventKey:
		return
	
	for command in commands:
		if event.is_action_pressed(command):
			commands[command].call()
			Global.next_turn.emit()
	
	#if event.is_action_pressed("move_left", true):
	#	entity.try_move(Vector2(-1, 0))
	#	Global.next_turn.emit()
	#if event.is_action_pressed("move_right", true):
	#	entity.try_move(Vector2(1, 0))
	#	Global.next_turn.emit()
	#if event.is_action_pressed("move_up", true):
	#	entity.try_move(Vector2(0, -1))
	#	Global.next_turn.emit()
	#if event.is_action_pressed("move_down", true):
	#	entity.try_move(Vector2(0, 1))
	#	Global.next_turn.emit()

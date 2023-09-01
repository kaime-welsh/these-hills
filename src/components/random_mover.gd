class_name RandomMover extends Component

func tick() -> void:
	entity.try_move(Vector2(
		randi_range(-1,1),
		randi_range(-1,1),
	))

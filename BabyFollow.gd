extends PathFollow2D

export var runSpeed = 250

func _process(delta):
	return set_offset(get_offset() + runSpeed * delta)

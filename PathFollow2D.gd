extends PathFollow2D


var runSpeed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		return set_offset(get_offset() + runSpeed * delta)

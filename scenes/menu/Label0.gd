extends Label

export (int) var speed = 13
export (bool) var fade = false

var time = 0
var sinTime = 0
var _visible = true
var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func flash():
	if !fade:
		if sinTime > 0:
			_visible = true
		else:
			_visible = false
	else:
		_visible = true
		modulate.a = sinTime
	visible = _visible

func _process(delta):
	time += delta
	sinTime = sin(time*speed)
	if selected == 1:
		flash()
	pass

extends Label

export (int) var speed = 5
export (bool) var fade = false

var time = 0
var sinTime = 0
var _visible = true


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	sinTime = sin(time*speed)
	flash()
	pass

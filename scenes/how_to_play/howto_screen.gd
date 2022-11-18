extends Control



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal confirm
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("confirm"):
			print("asdjkho")
			emit_signal("confirm")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _toggled(button_pressed):
	$Sprite.show()
	$ColorRect/AnimationPlayer.play("Fade")
	print("aa")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

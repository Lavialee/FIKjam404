extends AnimatedSprite


func _ready():
	randomize()

func baby_type(animation_name):
	play(animation_name)
	return animation_name
	

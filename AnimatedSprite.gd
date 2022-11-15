extends AnimatedSprite

func _ready():
	randomize()
	baby_type()

func baby_type():
	var animations = frames.get_animation_names()
	var animation_id = randi() % animations.size()
	var animation_name = animations[animation_id]
	play(animation_name)
	return animation_name
	

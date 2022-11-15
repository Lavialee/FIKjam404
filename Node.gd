extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var animation_name
# Called when the node enters the scene tree for the first time.
func _ready():
	var animations = $AnimatedSprite.frames.get_animation_names()
	var animation_id = randi() % animations.size()
	animation_name = animations[animation_id]
	$AnimatedSprite.baby_type(animation_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

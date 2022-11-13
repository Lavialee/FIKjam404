extends Node

export(PackedScene) var mob_scene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	var baby_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = baby_types[randi() % baby_types.size()]
	print(baby_types)
	print(baby_types[randi() % baby_types.size()])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

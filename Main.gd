extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#if baby type = thing, despawn, make new baby, add score	
#if not ubrat na timeru za trest
func _on_Baby_saved():
	score += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


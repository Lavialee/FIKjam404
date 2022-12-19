extends Node

var scores : Array

var player_score
var player_nick
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()

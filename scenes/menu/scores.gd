extends Node2D

signal back
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func your_score(score):
	yield(get_tree().create_timer(1), "timeout")
	print(score)
	$Spaseno.text = "Spaseno: "+ str(score)
	yield(get_tree().create_timer(1), "timeout")

func _unhandled_input(event):
	emit_signal("back")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

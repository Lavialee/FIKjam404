extends Node2D


signal babychange
var baby

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	baby_type_randomizer()

func baby_type_randomizer():
	baby = (randi() % 4)
	emit_signal("babychange")

func baby_saved():
	baby = 1
	emit_signal("babychange")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

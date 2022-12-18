extends Node2D

signal babychange
var baby
var baby_heal
func _ready():
	randomize()
	baby_type_randomizer()

func baby_type_randomizer():
	baby = (randi() % 6)
	if baby == 2 or baby == 3:
		baby_heal = 2
	elif baby == 4 or baby ==5:
		baby_heal = 3
	else:
		baby_heal = baby
	emit_signal("babychange")

func baby_saved():
	baby_heal = 1
	emit_signal("babychange")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

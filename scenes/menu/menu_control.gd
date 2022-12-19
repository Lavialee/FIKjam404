extends Control
class_name Player
signal startgame
signal leaderboard

var showing = 0

func _ready():
	$buttons/zahajit_obrad.grab_focus()

func _on_jak_hrat_pressed():
	if showing == 0:
		$how_to.show()
		showing = 1
		return

	elif showing == 1:
		$how_to.hide()
		showing = 0
		return

func _on_leaderboard_pressed():
	if showing == 0:
		emit_signal("leaderboard")
		pass # Replace with function body.

func _on_zahajit_obrad_pressed():
	if showing == 0:
		$door_sprite.show()
		$door_sound.play()
		emit_signal("startgame")
		return

	elif showing == 1:
		$how_to.hide()
		showing = 0
		return



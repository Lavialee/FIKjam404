extends Control

signal startgame
signal howto

func _ready():
	$zahajit_obrad.grab_focus()

func _on_jak_hrat_pressed():
	emit_signal("howto")

func _on_zahajit_obrad_pressed():
	emit_signal("startgame")


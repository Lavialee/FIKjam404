extends Control

signal browseright
signal browseleft
signal handconfirm
signal handuse

func _ready():
	$Sul.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_right"):
		emit_signal("browseright")
	if event.is_action_pressed("ui_left"):
		emit_signal("browseleft")
	if event.is_action_pressed("confirm"):
		emit_signal("handconfirm")
	if event.is_action_pressed("use"):
		emit_signal("handuse")

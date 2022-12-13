extends Control

signal browseright
signal browseleft
signal handconfirm
signal handuse
signal up
signal down

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("ui_right"):
		emit_signal("browseright")
	if event.is_action_pressed("ui_left"):
		emit_signal("browseleft")
	if event.is_action_pressed("confirm"):
		emit_signal("handconfirm")
	if event.is_action_pressed("use"):
		emit_signal("handuse")
	if event.is_action_pressed("ui_up"):
		emit_signal("up")
	if event.is_action_pressed("ui_down"):
		emit_signal("down")

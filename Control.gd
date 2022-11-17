extends Control

signal browseright
signal browseleft
signal hand (state)

var ruka = 0

func _ready():
	$Sul.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_right") and get_focus_owner() != $Bible and ruka == 0:
			emit_signal("browseright")
	if event.is_action_pressed("ui_left") and get_focus_owner() != $Sul and ruka == 0:
		emit_signal("browseleft")
	if event.is_action_pressed("confirm"):
		if ruka == 0:
			ruka = 1
			emit_signal("hand",ruka)
			return
		if ruka == 1 or 2:
			ruka = 3  
			emit_signal("hand", ruka)
			ruka = 0
			return

	if event.is_action_pressed("use"):
		if ruka == 0:
			ruka = 0
			emit_signal("hand",ruka)
			return
		if ruka == 1 or 2:
			ruka = 2
			emit_signal("hand",ruka)
			return
			
#func _process(delta):
#	pass

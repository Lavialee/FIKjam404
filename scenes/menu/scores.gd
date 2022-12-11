extends Node2D


const ALPHABET = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

var blink = false
var selected_letter = 0
var letters = {"letter0": 0, "letter1": 0, "letter2": 0}

signal back

func _ready():
	pass

func your_score(score):
	yield(get_tree().create_timer(1), "timeout")
	$ColorRect/Spaseno.text = "Spaseno: "+ str(score)
	yield(get_tree().create_timer(1), "timeout")

func _input(event):
	if event.is_action_pressed("ui_right") or event.is_action_pressed("confirm"):
		if selected_letter < 2:
			selected_letter = +1
		elif selected_letter == 2:
			selected_letter = 0
#move one place right

	if event.is_action_pressed("ui_left"):
		if selected_letter > 0:
			selected_letter = -1
		elif selected_letter == 0:
			selected_letter = 2
		pass #move one place left

	if event.is_action_pressed("ui_up"):
		if letters['letter%s' % selected_letter] < 26:
			letters['letter%s' % selected_letter] =+1
		elif letters['letter%s' % selected_letter] == 26:
			letters['letter%s' % selected_letter] = 0
		#letterselected.set_text(ALPHABET[
		pass #move up alphabet once, wait for a little while then holding (find out if joysticks work while pressing)

	if event.is_action_pressed("ui_down"):
		if letters['letter%s' % selected_letter] >0:
			letters['letter%s' % selected_letter] =-1
		elif letters['letter%s' % selected_letter] == 0:
			letters['letter%s' % selected_letter] = 26
		pass #move down alphabet

	if event.is_action_pressed("use"):
		emit_signal("back")
		pass #use name
	 
func _process(delta):
	#check what the letter is selected, make it blink ideally
	pass
	

extends Node2D

const ALPHABET = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
var blink = false
var selected_label = 0
var letters = [0,0,0,0]
var labels
var nickname = 0
signal back

func _ready():
	labels = [$Label0, $Label1 ,$Label2, $Label3]
	for label in labels:
		label.set_text(ALPHABET[selected_label]) 
	blinking()

func your_score(score):
	Global.player_score = score
	yield(get_tree().create_timer(1), "timeout")
	$ColorRect/Spaseno.text = "Spaseno: "+ str(score)
	yield(get_tree().create_timer(1), "timeout")

func change_character():
	var changed_letter = letters[selected_label]
	labels[selected_label].set_text(ALPHABET[changed_letter])
	labels[selected_label].visible = true
	pass

func blinking():
	for label in labels:
		label.visible = true
		label.selected = 0
	labels[selected_label].selected = 1
	pass

func _input(event):
	if event.is_action_pressed("confirm"): # or event.is_action_pressed("confirm"): #move one place right
		selected_label = (selected_label + 1) % 4
		blinking()
#
	if event.is_action_pressed("ui_up"): #move up alphabet
		letters[selected_label] = (letters[selected_label] + 1) % 26
		change_character()

	if event.is_action_pressed("ui_down"):  #move down alphabet
		letters[selected_label] = (letters[selected_label] - 1)
		if letters[selected_label] == -1:
			letters[selected_label] = 25
		change_character()

	if event.is_action_pressed("use"):  #use name
		nickname = str(ALPHABET[letters[0]]) + str(ALPHABET[letters[1]]) + str(ALPHABET[letters[2]]) + str(ALPHABET[letters[3]])
		Global.player_nick = nickname
		#UPDATE NAME
		emit_signal("back")

extends Node2D

const ALPHABET_caps = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
const ALPHABET = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
var blink = false
var selected_label = 0
var letters = {"letter0": 0, "letter1": 0, "letter2": 0, "letter3":0}
var labels

signal back


func _ready():
    labels = [$Label0, $Label1 ,$Label2, $Label3 ]
    for label in labels:
        label.set_text(ALPHABET[selected_label]) 

func your_score(score):
    yield(get_tree().create_timer(1), "timeout")
    $ColorRect/Spaseno.text = "Spaseno: "+ str(score)
    yield(get_tree().create_timer(1), "timeout")

func change_character():
    var changed_letter = letters.values()[selected_label]
    print(selected_label)
    #var calling = "$Label%d.set_text(ALPHABET[changed_letter])" % selected_label
    if selected_label == 0:
        labels[0].set_text(ALPHABET_caps[changed_letter])
    elif selected_label == 1:
        $Label1.set_text(ALPHABET[changed_letter])
    elif selected_label == 2:
        $Label2.set_text(ALPHABET[changed_letter])
    else:
        $Label3.set_text(ALPHABET[changed_letter])
    #call(calling)
#	$LabelXYZ.set_text(ALPHABET[changed_letter]) #CALL METHOD
    pass

func _input(event):
    if event.is_action_pressed("ui_right") or event.is_action_pressed("confirm"):
        if selected_label < 3:
            selected_label += 1
        elif selected_label == 3:
            selected_label = 0
#move one place right

    if event.is_action_pressed("ui_left"):
        if selected_label > 0:
            selected_label -= 1
        elif selected_label == 0:
            selected_label = 3
        pass #move one place left

    if event.is_action_pressed("ui_up"): #modulo (zbytek) změnit
        letters['letter%s' % selected_label] = (letters['letter%s' % selected_label] + 1) % 26
        #změnit text
        change_character()
        pass #move up alphabet once, wait for a little while then holding (find out if joysticks work while pressing)

    if event.is_action_pressed("ui_down"):
        if letters['letter%s' % selected_label] >0:
            letters['letter%s' % selected_label] -= 1
        elif letters['letter%s' % selected_label] == 0:
            letters['letter%s' % selected_label] = 25
        change_character()
        pass #move down alphabet

    if event.is_action_pressed("use"):
        emit_signal("back")
        pass #use name
     
    
func _process(delta):
    #check what the letter is selected, make it blink ideally
    pass
    

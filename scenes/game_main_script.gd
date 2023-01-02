extends Node2D

signal timerend

onready var browse = $browsing_animating
#onready var baby_type = $baby_type
onready var baby_animation0 = $baby_animation_node0
onready var baby_animation1 = $baby_animation_node1

var time = 50
var score = 0

var stun = false
var selected = 0
var hand_full = false
var baby_number = 0
var busy = false

var baby_type
var baby_heal

func _ready():
	randomize()
	baby_type_randomizer()
	baby_animation0.baby_type(baby_type)
	
func baby_type_randomizer():
	baby_type = (randi() % 6)
	if baby_type == 2 or baby_type == 3:
		baby_heal = 2
	elif baby_type == 4 or baby_type == 5:
		baby_heal = 3
	else:
		baby_heal = baby_type

func baby_saved():
	baby_animation0.baby_saved()
	baby_animation1.baby_saved()
	baby_heal = 1

func _input(event):
	if event.is_action_pressed("ui_left"):
		if busy == false and hand_full == false and selected != 0:
			selected -= 1
			browse.browse_left_movement()

	if event.is_action_pressed("ui_right"):
		if busy == false and hand_full == false and selected != 3:
			selected += 1
			browse.browse_right_movement()

	if event.is_action_pressed("confirm"):
		if busy == false and hand_full == false:
			browse.animate_grab()
			hand_full = true
			yield(get_tree().create_timer(3), "timeout")
			return #animate grab, change state
		elif busy == true:
			print("busy is ", busy, " should be true")
		elif busy == false and hand_full == true:
			print("busy is ", busy, " should be true")
			browse.animate_put_down()
			hand_full = false
			return #animate lay down, change state

	if event.is_action_pressed("use"):
		if busy == false and hand_full == true:
			browse.animate_use()
			busy = true
			check_correctness()
			yield(get_tree().create_timer(1), "timeout") 
			browse.stop(true)
#			busy = false TADYTOHLE JE PROBLEM
			return #animate use, stall until finished, check correctness, state 

func _on_Timer_timeout():
	time -= 1
	$TimeLine.points[1].x -= 10
	if time <=0:
		$Timer.stop()
		emit_signal("timerend", score)

func check_correctness():
	if selected == baby_heal:
		if baby_heal == 1 and baby_number == 0:
			baby_animation0.baby_despawn()
			baby_type_randomizer()
			baby_animation1.baby_type(baby_type)
			baby_number = 1
			score += 1
			return

		elif baby_heal == 1 and baby_number == 1:
			baby_animation1.baby_despawn()
			baby_type_randomizer()
			baby_animation0.baby_type(baby_type)
			baby_number = 0
			score += 1
			return

		else:
			baby_saved()
			return

	if selected != baby_heal:
		if baby_heal == 1:
			baby_animation0.baby_water_shake()
			baby_animation1.baby_water_shake()
		else:
			busy = true
			print("busy is ", busy, " should be true")
			baby_animation0.baby_wrong()
			baby_animation1.baby_wrong()
			yield(get_tree().create_timer(3), "timeout")
			busy = false
			print("busy is ", busy, " should be false")
		return

func _process(_delta):
	$Text/Score.text = "Zachránils: "+str(score)
	print(busy)
